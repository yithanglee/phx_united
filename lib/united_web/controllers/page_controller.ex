defmodule UnitedWeb.PageController do
  use UnitedWeb, :controller
  require IEx

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def export_csv(conn, %{"type" => type}) do
    csv_data = United.Settings.raw_sql(type)

    {headers, rows} =
      case csv_data do
        {:ok,
         %Postgrex.Result{
           columns: headers,
           rows: rows
         }} ->
          {headers, rows}

        _ ->
          {[], []}
      end

    headers = headers |> Enum.join(",")

    list =
      for row <- rows do
        row |> Enum.join(",")
      end
      |> Enum.join("\n")

    bom = <<0xEF, 0xBB, 0xBF>>

    my_string = (headers <> "\n" <> list) |> IO.inspect()

    string_with_bom = <<bom::binary, my_string::binary>>

    conn
    |> put_resp_content_type("text/csv; charset=utf-8")
    |> put_resp_header("content-disposition", "attachment; filename=#{type}.csv")
    |> send_resp(200, string_with_bom)
  end

  def show_event(conn, %{"id" => id} = params) do
    bi = United.Settings.get_event!(id)

    img_url = nil

    conn =
      conn
      |> put_session(:title, bi.name)
      |> put_session(:description, bi.description)
      |> put_session(
        :img_url,
        bi.img_url
      )

    render(conn, "index.html", params)
  end

  def show_book(conn, %{"id" => id} = params) do
    bi = United.Settings.book_data(%{"bi" => id})

    img_url =
      if bi.book.book_images != [] do
        bi.book.book_images |> List.first() |> Map.get(:img_url)
      else
        nil
      end

    conn =
      conn
      |> put_session(:title, bi.book.title)
      |> put_session(:description, bi.book.description)
      |> put_session(
        :img_url,
        img_url
      )

    render(conn, "index.html", params)
  end

  def show_page(conn, params) do
    render(conn, "show.html", params)
  end

  def member_dashboard(conn, _params) do
    render(conn, "member_dashboard.html", layout: {UnitedWeb.LayoutView, "member.html"})
  end

  def dashboard(conn, _params) do
    render(conn, "dashboard.html")
  end
end
