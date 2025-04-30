defmodule United do
  @moduledoc """
  United keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  # import Mogrify
  use Joken.Config

  def firebase_config() do
    # AIzaSyCShSjvz1ZBrgXrxVOG_X3u19U9coEdiGk
    # %{
    #   apiKey: "AIzaSyC1LklnwigrQdW1RrJGuo0Pj7YTBWrCgTw",
    #   authDomain: "kjcmc-library.firebaseapp.com",
    #   projectId: "kjcmc-library",
    #   storageBucket: "kjcmc-library.appspot.com",
    #   messagingSenderId: "169717908484",
    #   appId: "1:169717908484:web:4d9c5c2fc96ce2cac9a151"
    # }
    Application.get_env(:united, :firebase) |> Enum.into(%{})
  end

  def firebase(uid \\ "xCzTLRVIZ8VKQjHbDy96cMl04yJ3") do
    api_key = Application.get_env(:united, :firebase)[:api_key]
    url = "https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=#{api_key}"

    url =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=#{api_key}"

    headers = [
      {"content-type", "application/json"}
    ]

    case HTTPoison.post(
           url,
           Jason.encode!(%{returnSecureToken: true, token: "damien.united.kjcmc"}),
           headers
         ) do
      {:ok, %{body: body} = resp} ->
        body |> Jason.decode!()

      _ ->
        nil
    end
  end

  def loan_reminder_check(string) do
    IO.inspect("checks #{string}")
  end

  # todo: add the email flags to identify if the mails were sent out..
  def loan_reminder(_string, organization_id \\ nil) do
    insert_fine = fn map ->
      if map.member != nil do
        IO.inspect(map.member)
        fine_amount = map.member.group.fine_amount
        fine_days = map.member.group.fine_days
        qty = (Date.diff(Date.utc_today(), map.return_date) / fine_days) |> Float.round()

        map
        |> Map.put(:late_days, Date.diff(Date.utc_today(), map.return_date))
        |> Map.put(:fine_amount, fine_amount * qty)
        |> IO.inspect()
      end
    end

    members =
      United.Settings.all_outstanding_loans()
      |> Enum.map(&(&1 |> BluePotion.sanitize_struct() |> insert_fine.()))
      |> Enum.reject(&(&1 == nil))
      |> Enum.filter(&(&1.late_days > -7))
      |> Enum.group_by(& &1.member)
      |> IO.inspect()

    for member <- members |> Map.keys() do
      loans = members[member]
      books = Enum.map(loans, &{&1.book, &1.return_date})

      case United.Mailer.send_email_for_org(
             member.organization,
             United.Email.remind_email(
               member.email,
               member,
               books,
               %United.Settings.Organization{}
               |> Map.merge(member.organization)
             )
           )
           |> IO.inspect(label: "mailer") do
        {:ok, %Bamboo.Email{html_body: html_body} = resp} ->
          IO.inspect(resp)

          United.Settings.create_email_reminder(%{
            member_id: member.id,
            is_sent: true,
            content: html_body
          })

        _ ->
          United.Settings.create_email_reminder(%{
            member_id: member.id,
            is_sent: false,
            content: ""
          })

          nil
      end
    end
  end

  def ensure_gtoken_kv_created() do
    if Process.whereis(:gtoken_kv) == nil do
      {:ok, pid} = Agent.start_link(fn -> %{} end)
      Process.register(pid, :gtoken_kv)

      IO.inspect("gtoken_kv kv created")
    else
      IO.inspect("gtoken_kv kv exist")
    end
  end

  def inspect_images(b64_images) do
    ensure_gtoken_kv_created()
    pid = Process.whereis(:gtoken_kv)

    token = Agent.get(pid, fn map -> map["token"] end)

    headers = [
      {"content-type", "application/json"},
      {"Authorization", "Bearer #{token}"}
    ]

    url = "https://vision.googleapis.com/v1/images:annotate"

    images =
      for b64_image <- b64_images do
        %{
          image: %{content: b64_image},
          features: [%{type: "TEXT_DETECTION"}]
        }
      end

    error_message =
      for b64_image <- b64_images do
        "cant decode in timely manner, please try again."
      end

    body =
      %{
        requests: images
      }
      |> Jason.encode!()

    case HTTPoison.post(url, body, headers, recv_timeout: 10_000) do
      {:ok, resp} ->
        d =
          resp.body
          |> Jason.decode!()
          |> IO.inspect()

        d2 =
          d
          |> Map.get("responses")

        if d2 != nil do
          d3s =
            for dz <- d2 do
              dz
              |> IO.inspect()
              |> Kernel.get_in(["fullTextAnnotation", "text"])
            end

          UnitedWeb.Endpoint.broadcast("user:lobby", "decoded_images", %{
            data: d3s,
            b64_image: b64_images
          })
        else
          token = get_gtoken()
          Agent.update(pid, fn map -> Map.put(map, "token", token) end)
          inspect_images(b64_images)
        end

      {:error, reason} ->
        IO.inspect(reason)

        UnitedWeb.Endpoint.broadcast("user:lobby", "decoded_images", %{
          data: error_message,
          b64_image: b64_images
        })
    end
  end

  def inspect_image(b64_image) do
    ensure_gtoken_kv_created()
    pid = Process.whereis(:gtoken_kv)

    token = Agent.get(pid, fn map -> map["token"] end)

    headers = [
      {"content-type", "application/json"},
      {"Authorization", "Bearer #{token}"}
    ]

    url = "https://vision.googleapis.com/v1/images:annotate"

    body =
      %{
        requests: [
          %{
            image: %{content: b64_image},
            features: [%{type: "TEXT_DETECTION"}]
          }
        ]
      }
      |> Jason.encode!()

    case HTTPoison.post(url, body, headers) do
      {:ok, resp} ->
        d =
          resp.body
          |> Jason.decode!()
          |> IO.inspect()

        d2 =
          d
          |> Map.get("responses")

        if d2 != nil do
          d3 =
            d2
            |> List.first()
            |> Map.get("fullTextAnnotation")
            |> Map.get("text")

          UnitedWeb.Endpoint.broadcast("user:lobby", "decoded_image", %{
            data: d3,
            b64_image: b64_image
          })
        else
          token = get_gtoken()
          Agent.update(pid, fn map -> Map.put(map, "token", token) end)
          inspect_image(b64_image)
        end

      {:error, reason} ->
        IO.inspect(reason)

        UnitedWeb.Endpoint.broadcast("user:lobby", "decoded_image", %{
          data: "",
          b64_image: b64_image
        })
    end
  end

  def get_gtoken() do
    filename = "assetmanagement-lh-724d2fa50035.json"
    path = Application.app_dir(:united)
    gdata = File.read!("#{path}/priv/static/#{filename}") |> Jason.decode!()

    {:ok, c3} =
      Joken.Signer.sign(
        %{
          iss: gdata["client_email"],
          scope: "https://www.googleapis.com/auth/cloud-vision",
          aud: "https://oauth2.googleapis.com/token",
          exp: DateTime.utc_now() |> Timex.shift(hours: 1) |> DateTime.to_unix(),
          iat: DateTime.utc_now() |> DateTime.to_unix()
        },
        Joken.Signer.parse_config(:rs256)
      )
      |> IO.inspect()

    body =
      "grant_type=#{URI.encode_www_form("urn:ietf:params:oauth:grant-type:jwt-bearer")}&assertion=#{c3}"

    {:ok, resp} =
      HTTPoison.post("https://oauth2.googleapis.com/token", body, [
        {"content-type", "application/x-www-form-urlencoded"}
      ])

    a = resp.body |> Jason.decode!()
    a["access_token"] |> String.replace("..", "")
  end

  def eval_codes(singular, plural) do
    struct =
      singular |> String.split("_") |> Enum.map(&(&1 |> String.capitalize())) |> Enum.join("")

    _dynamic_code =
      """
        alias United.Settings.#{struct}
        def list_#{plural}() do
          Repo.all(#{struct})
        end
        def get_#{singular}!(id) do
          Repo.get!(#{struct}, id)
        end
        def create_#{singular}(params \\\\ %{}) do
          #{struct}.changeset(%#{struct}{}, params) |> Repo.insert()
        end
        def update_#{singular}(model, params) do
          #{struct}.changeset(model, params) |> Repo.update()
        end
        def delete_#{singular}(%#{struct}{} = model) do
          Repo.delete(model)
        end

        random_id = makeid(4)
        #{singular}Source = new phoenixModel({
          columns: [
          
            { label: 'id', data: 'id' },
            { label: 'Action', data: 'id' }

          ],
          moduleName: "#{struct}",
          link: "#{struct}",
          customCols: customCols,
          buttons: [{
            buttonType: "grouped",
            name: "Manage",
            color: "outline-warning",
            buttonList: [

              {
                name: "Edit",
                iconName: "fa fa-edit",
                color: "btn-sm btn-outline-warning",
                onClickFunction: editData,
                fnParams: {
                  drawFn: enlargeModal,
                  customCols: customCols
                }
              },
              {
                name: "Delete",
                iconName: "fa fa-trash",
                color: "outline-danger",
                onClickFunction: deleteData,
                fnParams: {}
              }
            ],
            fnParams: {

            }
            }, ],
          tableSelector: "#" + random_id
        })
        #{singular}Source.load(random_id, "#tab1")



          function call#{struct}() {
            #{singular}Source2 = new phoenixModel({
              columns: [{
                  label: 'Name',
                  data: 'name'
                },
                {
                  label: 'Action',
                  data: 'id'
                }
              ],
              moduleName: "#{struct}",
              link: "#{struct}",
              buttons: [{
                name: "Select",
                iconName: "fa fa-check",
                color: "btn-sm btn-outline-success",
                onClickFunction: (params) => {
                  var dt = params.dataSource;
                  var table = dt.table;
                  var data = table.data()[params.index]
                  console.log(data.id)
                  $("input[name='Book[#{singular}][name]']").val(data.name)
                  $("input[name='Book[#{singular}][id]']").val(data.id)
                  $("input[name='Book[#{singular}_id]']").val(data.id)
                  $("#myModal").modal('hide')
                },
                fnParams: {
                 
                }
              }, ],
              tableSelector: "#" + random_id
            })
            App.modal({
              selector: "#myModal",
              autoClose: false,
              header: "Search #{struct}",
              content: `
              <div id="#{singular}">

              </div>`
            })
            #{singular}Source2.load(makeid(4), '##{singular}')
            #{singular}Source2.table.on("draw", function() {
              if ($("#search_user").length == 0) {
                $(".module_buttons").prepend(`
                  <label class="col-form-label " for="inputSmall">#{struct} </label>
                  <input class="mx-4 form-control form-control-sm" id="search_user"></input>
                            `)
              }
              $('input#search_user').on('change', function(e) {
                var query = $(this).val()
                #{singular}Source2.table
                  .columns(0)
                  .search(query)
                  .draw();
              })
            })
          }




      """
      |> IO.puts()
  end

  def upload_file(params) do
    check_upload =
      Map.values(params)
      |> Enum.with_index()
      |> Enum.filter(fn x -> is_map(elem(x, 0)) end)
      |> Enum.filter(fn x -> :__struct__ in Map.keys(elem(x, 0)) end)
      |> Enum.filter(fn x -> elem(x, 0).__struct__ == Plug.Upload end)

    if check_upload != [] do
      file_plug = hd(check_upload) |> elem(0)
      index = hd(check_upload) |> elem(1)

      check = File.exists?(File.cwd!() <> "/media")

      path =
        if check do
          File.cwd!() <> "/media"
        else
          File.mkdir(File.cwd!() <> "/media")
          File.cwd!() <> "/media"
        end

      final =
        if is_map(file_plug) do
          IO.inspect(is_map(file_plug))
          fl = String.replace(file_plug.filename, "'", "")
          File.cp(file_plug.path, path <> "/#{fl}")
          "/images/uploads/#{fl}"
        else
          "/images/uploads/#{file_plug}"
        end

      Map.put(params, Enum.at(Map.keys(params), index), final)
    else
      params
    end
  end

  def create_new_bucket(bucket_name) do
    url = "https://api.linode.com/v4/object-storage/buckets"

    token = Application.get_env(:ex_aws, :pat)

    resp =
      HTTPoison.post(url, Poison.encode!(%{label: bucket_name, cluster: "ap-south-1"}), [
        {"Authorization", "Bearer #{token}"},
        {"Content-Type", "application/json"}
      ])

    case resp do
      {:ok, res} ->
        res.body |> Poison.decode!()

      {:error, error} ->
        IO.inspect(error)
        ""
    end
  end

  def list_bucket() do
    token = Application.get_env(:ex_aws, :pat)

    # `44675ea568c8d8605fe7af0bf7ce66de28f751f25cc62b87fff970080f31b31f
    resp =
      HTTPoison.get("https://api.linode.com/v4/object-storage/buckets", [
        {"Authorization", "Bearer #{token}"}
      ])

    case resp do
      {:ok, res} ->
        res.body |> Poison.decode!()

      {:error, error} ->
        IO.inspect(error)
        ""
    end
  end

  def s3_large_upload(filename) do
    opts = [acl: :public_read]

    check = File.exists?(File.cwd!() <> "/media")

    path =
      if check do
        File.cwd!() <> "/media"
      else
        File.mkdir(File.cwd!() <> "/media")
        File.cwd!() <> "/media"
      end

    res =
      "#{path}/#{filename}"
      |> ExAws.S3.Upload.stream_file()
      |> ExAws.S3.upload(
        "damien-bucket",
        filename,
        opts
      )
      |> ExAws.request!()

    data = res.body |> SweetXml.parse()
    IO.inspect(data |> Tuple.to_list())
    :ok
  end
end
