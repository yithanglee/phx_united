defmodule United.Settings do
  @moduledoc """
  The Settings context.
  """

  import Ecto.Query, warn: false
  alias United.Repo

  def append_bool_key(params, bool_key) do
    if bool_key in Map.keys(params) do
      params |> Map.put(bool_key, Map.get(params, bool_key) == "on")
    else
      params |> Map.put(bool_key, false)
    end
  end

  alias United.Settings.BookSource

  def list_book_sources() do
    Repo.all(BookSource)
  end

  def get_book_source!(id) do
    Repo.get!(BookSource, id)
  end

  def create_book_source(params \\ %{}) do
    BookSource.changeset(%BookSource{}, params) |> Repo.insert()
  end

  def update_book_source(model, params) do
    BookSource.changeset(model, params) |> Repo.update()
  end

  def delete_book_source(%BookSource{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.Organization

  def list_organizations() do
    Repo.all(Organization)
  end

  def get_organization_by_host_name(host_name) do
    Repo.all(from o in Organization, where: ilike(o.host_name, ^"%#{host_name}%")) |> List.first()
  end

  def get_organization_by_id(id) do
    Repo.get(Organization, id)
  end

  def create_organization(params \\ %{}) do
    Organization.changeset(%Organization{}, params) |> Repo.insert()
  end

  def update_organization(model, params) do
    Organization.changeset(model, params) |> Repo.update()
  end

  def delete_organization(%Organization{} = model) do
    Repo.delete(model)
  end

  def get_organization!(id) do
    Repo.get(Organization, id)
    # case BluePotion.read_file("organization.json") do
    #   {:error, _reasons} ->
    #     %{
    #       library_name: "Library System",
    #       full_name: "Your Organization",
    #       address: "Your full address",
    #       website: "https://www.google.com",
    #       image_url: "/images/uploads/logo.png",
    #       opening_hours: "Sun: 9:00am to 12:00pm",
    #       rules: """
    #       <ol>
    #       <li><span class="fs-5">会员注册</span>
    #       <ol>
    #         <li>向管理员获取注册链接。</li>
    #       </ol>
    #       </li>
    #       <li>
    #       <span class="fs-5">借阅规则</span>
    #       <ol>
    #         <li>借阅条件： 登入自己的账号借阅。仅限本人使用，不得转借他人。</li>
    #         <li>本馆仅供加影堂会友借阅。社区非信徒需入馆三次才获准注册成为会员并借阅。</li>
    #         <li>期刊，堂会纪念册或无编号书籍，仅限馆内参阅，概不外借。</li>
    #         <li>
    #           牧者，同工及会友可借书册数及借期如下：
    #           <ol>
    #             <li>牧者以6册为限，借期2个月</li>
    #             <li>同工以4册为限，借期2个月</li>
    #             <li>会友以2册为限，借期1个月</li>
    #           </ol>
    #         </li>
    #       </ol>
    #       </li>
    #       <li>
    #       <span class="fs-5">续借</span>
    #       <ol>
    #         <li>所借书籍届满，若无人预约，可续借一次。</li>
    #         <li>借书者可自行通过系统办理续借。</li>
    #       </ol>
    #       </li>
    #       <li>
    #       <span class="fs-5">逾期</span>
    #       <ol>
    #         <li>借书册数已满定额或借期届满仍不归还者，不得另借他书。或所借图书有一本逾期即暂停借书权限，归还逾期图书后将自动恢复借书功能。</li>
    #         <li>
    #           届满之书，每逾一日，每册罚款RM0.20。
    #         </li>
    #       </ol>
    #       </li>
    #       <li>
    #       <span class="fs-5">赔偿</span>
    #       <ol>
    #         <li>借出书籍不得有遗失，涂画，撕毁，折角或其它损坏之行为。如有遗失或损坏，借书者须负赔偿责任。</li>
    #         <li>
    #           赔偿方式如下：
    #           <ul>
    #             <li>
    #               遗失之书籍可重购者，由借书者购回原书并偿付手续费RM5.00。
    #             </li>
    #             <li>
    #               如购买不到遗失之书籍，借书者应以原书的书价乘于二赔偿。
    #             </li>
    #           </ul>
    #         </li>
    #       </ol>
    #       </li>
    #       </ol>

    #       """
    #     }

    #   {:ok, bin} ->
    #     map = bin |> Jason.decode!()

    #     BluePotion.string_to_atom(map, Map.keys(map))
    # end
  end

  def get_organization() do
    case BluePotion.read_file("organization.json") do
      {:error, _reasons} ->
        %{status: "error"}

      {:ok, bin} ->
        %{status: "ok", data: bin |> Jason.decode!()}
    end
  end

  alias United.Settings.Event

  def list_events() do
    Repo.all(Event)
  end

  def get_event!(id) do
    Repo.get!(Event, id)
  end

  def create_event(params \\ %{}) do
    Event.changeset(%Event{}, params) |> Repo.insert()
  end

  def update_event(model, params) do
    Event.changeset(model, params) |> Repo.update()
  end

  def delete_event(%Event{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.User
  alias Ecto.Multi

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """

  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def get_user_by_fb_user_id(id) do
    Repo.get_by(User, fb_user_id: id) |> Repo.preload(:facebook_pages)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    IO.inspect(attrs)

    crypted_password =
      :crypto.hash(:sha512, attrs["password"]) |> Base.encode16() |> String.downcase()

    attrs = attrs |> Map.put("crypted_password", crypted_password)

    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    attrs =
      if "password" in Map.keys(attrs) do
        crypted_password =
          :crypto.hash(:sha512, attrs["password"]) |> Base.encode16() |> String.downcase()

        attrs |> Map.put("crypted_password", crypted_password)
      else
        attrs
      end

    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias United.Settings.Blog

  @doc """
  Returns the list of blogs.

  ## Examples

      iex> list_blogs()
      [%Blog{}, ...]

  """
  def list_blogs do
    Repo.all(Blog)
  end

  def list_recent_blogs() do
    Repo.all(from b in Blog, limit: 20, order_by: [desc: b.id])
  end

  @doc """
  Gets a single blog.

  Raises `Ecto.NoResultsError` if the Blog does not exist.

  ## Examples

      iex> get_blog!(123)
      %Blog{}

      iex> get_blog!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blog!(id), do: Repo.get!(Blog, id)

  @doc """
  Creates a blog.

  ## Examples

      iex> create_blog(%{field: value})
      {:ok, %Blog{}}

      iex> create_blog(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blog(attrs \\ %{}) do
    %Blog{}
    |> Blog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a blog.

  ## Examples

      iex> update_blog(blog, %{field: new_value})
      {:ok, %Blog{}}

      iex> update_blog(blog, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blog(%Blog{} = blog, attrs) do
    blog
    |> Blog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a blog.

  ## Examples

      iex> delete_blog(blog)
      {:ok, %Blog{}}

      iex> delete_blog(blog)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blog(%Blog{} = blog) do
    Repo.delete(blog)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blog changes.

  ## Examples

      iex> change_blog(blog)
      %Ecto.Changeset{data: %Blog{}}

  """
  def change_blog(%Blog{} = blog, attrs \\ %{}) do
    Blog.changeset(blog, attrs)
  end

  alias United.Settings.StoredMedia

  @doc """
  Returns the list of stored_medias.

  ## Examples

      iex> list_stored_medias()
      [%StoredMedia{}, ...]

  """
  def list_stored_medias do
    Repo.all(StoredMedia)
  end

  @doc """
  Gets a single stored_media.

  Raises `Ecto.NoResultsError` if the Stored media does not exist.

  ## Examples

      iex> get_stored_media!(123)
      %StoredMedia{}

      iex> get_stored_media!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stored_media!(id), do: Repo.get!(StoredMedia, id)

  @doc """
  Creates a stored_media.

  ## Examples

      iex> create_stored_media(%{field: value})
      {:ok, %StoredMedia{}}

      iex> create_stored_media(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stored_media(params \\ %{}) do
    a = StoredMedia.changeset(%StoredMedia{}, params) |> Repo.insert()

    case a do
      {:ok, sm} ->
        filename = sm.img_url |> String.replace("/images/uploads/", "")

        Task.start_link(United, :s3_large_upload, [filename])

        StoredMedia.changeset(sm, %{
          s3_url: "https://damien-bucket.ap-south-1.linodeobjects.com/#{filename}"
        })
        |> Repo.update()

      _ ->
        nil
    end

    a
  end

  def _create_stored_media(attrs \\ %{}) do
    a =
      %StoredMedia{}
      |> StoredMedia.changeset(attrs)
      |> Repo.insert()

    case a do
      {:ok, sm} ->
        filename = sm.s3_url |> String.replace("/images/uploads/", "")
        Task.start_link(United, :s3_large_upload, [filename])

        StoredMedia.changeset(sm, %{
          s3_url: "https://damien-bucket.ap-south-1.linodeobjects.com/#{filename}"
        })
        |> Repo.update()

        # goto s3
        nil

      _ ->
        nil
    end

    a
  end

  @doc """
  Updates a stored_media.

  ## Examples

      iex> update_stored_media(stored_media, %{field: new_value})
      {:ok, %StoredMedia{}}

      iex> update_stored_media(stored_media, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stored_media(%StoredMedia{} = stored_media, attrs) do
    stored_media
    |> StoredMedia.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a stored_media.

  ## Examples

      iex> delete_stored_media(stored_media)
      {:ok, %StoredMedia{}}

      iex> delete_stored_media(stored_media)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stored_media(%StoredMedia{} = stored_media) do
    Repo.delete(stored_media)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stored_media changes.

  ## Examples

      iex> change_stored_media(stored_media)
      %Ecto.Changeset{data: %StoredMedia{}}

  """
  def change_stored_media(%StoredMedia{} = stored_media, attrs \\ %{}) do
    StoredMedia.changeset(stored_media, attrs)
  end

  alias United.Settings.Shop

  @doc """
  Returns the list of shops.

  ## Examples

      iex> list_shops()
      [%Shop{}, ...]

  """
  def list_shops do
    Repo.all(Shop)
  end

  @doc """
  Gets a single shop.

  Raises `Ecto.NoResultsError` if the Shop does not exist.

  ## Examples

      iex> get_shop!(123)
      %Shop{}

      iex> get_shop!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shop!(id), do: Repo.get!(Shop, id)

  @doc """
  Creates a shop.

  ## Examples

      iex> create_shop(%{field: value})
      {:ok, %Shop{}}

      iex> create_shop(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shop(attrs \\ %{}) do
    %Shop{}
    |> Shop.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shop.

  ## Examples

      iex> update_shop(shop, %{field: new_value})
      {:ok, %Shop{}}

      iex> update_shop(shop, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shop(%Shop{} = shop, attrs) do
    shop
    |> Shop.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a shop.

  ## Examples

      iex> delete_shop(shop)
      {:ok, %Shop{}}

      iex> delete_shop(shop)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shop(%Shop{} = shop) do
    Repo.delete(shop)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shop changes.

  ## Examples

      iex> change_shop(shop)
      %Ecto.Changeset{data: %Shop{}}

  """
  def change_shop(%Shop{} = shop, attrs \\ %{}) do
    Shop.changeset(shop, attrs)
  end

  alias United.Settings.ShopProduct

  @doc """
  Returns the list of shop_products.

  ## Examples

      iex> list_shop_products()
      [%ShopProduct{}, ...]

  """
  def list_shop_products do
    Repo.all(ShopProduct)
  end

  @doc """
  Gets a single shop_product.

  Raises `Ecto.NoResultsError` if the Shop product does not exist.

  ## Examples

      iex> get_shop_product!(123)
      %ShopProduct{}

      iex> get_shop_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shop_product!(id), do: Repo.get!(ShopProduct, id)

  @doc """
  Creates a shop_product.

  ## Examples

      iex> create_shop_product(%{field: value})
      {:ok, %ShopProduct{}}

      iex> create_shop_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shop_product(attrs \\ %{}) do
    %ShopProduct{}
    |> ShopProduct.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shop_product.

  ## Examples

      iex> update_shop_product(shop_product, %{field: new_value})
      {:ok, %ShopProduct{}}

      iex> update_shop_product(shop_product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shop_product(%ShopProduct{} = shop_product, attrs) do
    shop_product
    |> ShopProduct.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a shop_product.

  ## Examples

      iex> delete_shop_product(shop_product)
      {:ok, %ShopProduct{}}

      iex> delete_shop_product(shop_product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shop_product(%ShopProduct{} = shop_product) do
    Repo.delete(shop_product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shop_product changes.

  ## Examples

      iex> change_shop_product(shop_product)
      %Ecto.Changeset{data: %ShopProduct{}}

  """
  def change_shop_product(%ShopProduct{} = shop_product, attrs \\ %{}) do
    ShopProduct.changeset(shop_product, attrs)
  end

  alias United.Settings.Tag

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """
  def list_tags do
    Repo.all(Tag)
  end

  @doc """
  Gets a single tag.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_tag!(123)
      %Tag{}

      iex> get_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag!(id), do: Repo.get!(Tag, id)

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{data: %Tag{}}

  """
  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end

  alias United.Settings.ShopProductTag

  @doc """
  Returns the list of shop_product_tags.

  ## Examples

      iex> list_shop_product_tags()
      [%ShopProductTag{}, ...]

  """
  def list_shop_product_tags do
    Repo.all(ShopProductTag)
  end

  @doc """
  Gets a single shop_product_tag.

  Raises `Ecto.NoResultsError` if the Shop product tag does not exist.

  ## Examples

      iex> get_shop_product_tag!(123)
      %ShopProductTag{}

      iex> get_shop_product_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shop_product_tag!(id), do: Repo.get!(ShopProductTag, id)

  @doc """
  Creates a shop_product_tag.

  ## Examples

      iex> create_shop_product_tag(%{field: value})
      {:ok, %ShopProductTag{}}

      iex> create_shop_product_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shop_product_tag(attrs \\ %{}) do
    %ShopProductTag{}
    |> ShopProductTag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shop_product_tag.

  ## Examples

      iex> update_shop_product_tag(shop_product_tag, %{field: new_value})
      {:ok, %ShopProductTag{}}

      iex> update_shop_product_tag(shop_product_tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shop_product_tag(%ShopProductTag{} = shop_product_tag, attrs) do
    shop_product_tag
    |> ShopProductTag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a shop_product_tag.

  ## Examples

      iex> delete_shop_product_tag(shop_product_tag)
      {:ok, %ShopProductTag{}}

      iex> delete_shop_product_tag(shop_product_tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shop_product_tag(%ShopProductTag{} = shop_product_tag) do
    Repo.delete(shop_product_tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shop_product_tag changes.

  ## Examples

      iex> change_shop_product_tag(shop_product_tag)
      %Ecto.Changeset{data: %ShopProductTag{}}

  """
  def change_shop_product_tag(%ShopProductTag{} = shop_product_tag, attrs \\ %{}) do
    ShopProductTag.changeset(shop_product_tag, attrs)
  end

  alias United.Settings.FacebookPage

  @doc """
  Returns the list of facebook_pages.

  ## Examples

      iex> list_facebook_pages()
      [%FacebookPage{}, ...]

  """
  def list_facebook_pages do
    Repo.all(FacebookPage)
  end

  @doc """
  Gets a single facebook_page.

  Raises `Ecto.NoResultsError` if the Facebook page does not exist.

  ## Examples

      iex> get_facebook_page!(123)
      %FacebookPage{}

      iex> get_facebook_page!(456)
      ** (Ecto.NoResultsError)

  """
  def get_facebook_page!(id), do: Repo.get!(FacebookPage, id)

  def get_facebook_page_by_pat(page_access_token) do
    Repo.all(
      from p in FacebookPage,
        where: p.page_access_token == ^page_access_token,
        preload: [:live_videos]
    )
  end

  @doc """
  Creates a facebook_page.

  ## Examples

      iex> create_facebook_page(%{field: value})
      {:ok, %FacebookPage{}}

      iex> create_facebook_page(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_facebook_page(attrs \\ %{}) do
    %FacebookPage{}
    |> FacebookPage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a facebook_page.

  ## Examples

      iex> update_facebook_page(facebook_page, %{field: new_value})
      {:ok, %FacebookPage{}}

      iex> update_facebook_page(facebook_page, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_facebook_page(%FacebookPage{} = facebook_page, attrs) do
    facebook_page
    |> FacebookPage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a facebook_page.

  ## Examples

      iex> delete_facebook_page(facebook_page)
      {:ok, %FacebookPage{}}

      iex> delete_facebook_page(facebook_page)
      {:error, %Ecto.Changeset{}}

  """
  def delete_facebook_page(%FacebookPage{} = facebook_page) do
    Repo.delete(facebook_page)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking facebook_page changes.

  ## Examples

      iex> change_facebook_page(facebook_page)
      %Ecto.Changeset{data: %FacebookPage{}}

  """
  def change_facebook_page(%FacebookPage{} = facebook_page, attrs \\ %{}) do
    FacebookPage.changeset(facebook_page, attrs)
  end

  alias United.Settings.LiveVideo

  @doc """
  Returns the list of live_videos.

  ## Examples

      iex> list_live_videos()
      [%LiveVideo{}, ...]

  """
  def list_live_videos do
    Repo.all(LiveVideo)
  end

  @doc """
  Gets a single live_video.

  Raises `Ecto.NoResultsError` if the Live video does not exist.

  ## Examples

      iex> get_live_video!(123)
      %LiveVideo{}

      iex> get_live_video!(456)
      ** (Ecto.NoResultsError)

  """
  def get_live_video!(id), do: Repo.get!(LiveVideo, id) |> Repo.preload(:facebook_page)

  def get_live_video_by_fb_id(id) do
    Repo.all(from lv in LiveVideo, where: lv.live_id == ^id) |> List.first()
  end

  @doc """
  Creates a live_video.

  ## Examples

      iex> create_live_video(%{field: value})
      {:ok, %LiveVideo{}}

      iex> create_live_video(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_live_video(attrs \\ %{}) do
    %LiveVideo{}
    |> LiveVideo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a live_video.

  ## Examples

      iex> update_live_video(live_video, %{field: new_value})
      {:ok, %LiveVideo{}}

      iex> update_live_video(live_video, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_live_video(%LiveVideo{} = live_video, attrs) do
    live_video
    |> LiveVideo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a live_video.

  ## Examples

      iex> delete_live_video(live_video)
      {:ok, %LiveVideo{}}

      iex> delete_live_video(live_video)
      {:error, %Ecto.Changeset{}}

  """
  def delete_live_video(%LiveVideo{} = live_video) do
    Repo.delete(live_video)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking live_video changes.

  ## Examples

      iex> change_live_video(live_video)
      %Ecto.Changeset{data: %LiveVideo{}}

  """
  def change_live_video(%LiveVideo{} = live_video, attrs \\ %{}) do
    LiveVideo.changeset(live_video, attrs)
  end

  alias United.Settings.VideoComment

  @doc """
  Returns the list of video_comments.

  ## Examples

      iex> list_video_comments()
      [%VideoComment{}, ...]

  """
  def list_video_comments do
    Repo.all(VideoComment)
  end

  @doc """
  Gets a single video_comment.

  Raises `Ecto.NoResultsError` if the Video comment does not exist.

  ## Examples

      iex> get_video_comment!(123)
      %VideoComment{}

      iex> get_video_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_video_comment!(id), do: Repo.get!(VideoComment, id)

  @doc """
  Creates a video_comment.

  ## Examples

      iex> create_video_comment(%{field: value})
      {:ok, %VideoComment{}}

      iex> create_video_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_video_comment(attrs \\ %{}) do
    pid =
      with pid <- Process.whereis(:comments),
           true <- pid != nil do
        pid
      else
        _ ->
          {:ok, pid} = Agent.start_link(fn -> [] end)
          Process.register(pid, :comments)
          pid
      end

    check =
      Agent.get(pid, fn list -> list end)
      |> Enum.reject(&(&1 == nil))
      |> Enum.filter(&(&1.ms_id == attrs.ms_id))

    pv =
      if check == [] do
        res = Repo.all(from p in VideoComment, where: p.ms_id == ^attrs.ms_id) |> List.first()

        f =
          if res == nil do
            %VideoComment{}
            |> VideoComment.changeset(attrs)
            |> Repo.insert!()
          else
            res
          end

        Agent.update(pid, fn list -> List.insert_at(list, 0, res) end)

        f
      else
        List.first(check)
      end
  end

  @doc """
  Updates a video_comment.

  ## Examples

      iex> update_video_comment(video_comment, %{field: new_value})
      {:ok, %VideoComment{}}

      iex> update_video_comment(video_comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_video_comment(%VideoComment{} = video_comment, attrs) do
    video_comment
    |> VideoComment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a video_comment.

  ## Examples

      iex> delete_video_comment(video_comment)
      {:ok, %VideoComment{}}

      iex> delete_video_comment(video_comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_video_comment(%VideoComment{} = video_comment) do
    Repo.delete(video_comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking video_comment changes.

  ## Examples

      iex> change_video_comment(video_comment)
      %Ecto.Changeset{data: %VideoComment{}}

  """
  def change_video_comment(%VideoComment{} = video_comment, attrs \\ %{}) do
    VideoComment.changeset(video_comment, attrs)
  end

  alias United.Settings.PageVisitor

  @doc """
  Returns the list of page_visitors.

  ## Examples

      iex> list_page_visitors()
      [%PageVisitor{}, ...]

  """
  def list_page_visitors do
    Repo.all(PageVisitor)
  end

  @doc """
  Gets a single page_visitor.

  Raises `Ecto.NoResultsError` if the Page visitor does not exist.

  ## Examples

      iex> get_page_visitor!(123)
      %PageVisitor{}

      iex> get_page_visitor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_page_visitor!(id), do: Repo.get!(PageVisitor, id)

  def get_page_visitor_by_psid(psid) do
    pid =
      with pid <- Process.whereis(:page_visitors),
           true <- pid != nil do
        pid
      else
        _ ->
          {:ok, pid} = Agent.start_link(fn -> [] end)
          Process.register(pid, :page_visitors)
          pid
      end

    check = Agent.get(pid, fn list -> list end) |> Enum.filter(&(&1.psid == psid))

    pv =
      if check == [] do
        res = Repo.all(from p in PageVisitor, where: p.psid == ^psid) |> List.first()

        if res != nil do
          Agent.update(pid, fn list -> List.insert_at(list, 0, res) end)
        end

        res
      else
        List.first(check)
      end
  end

  @doc """
  Creates a page_visitor.

  ## Examples

      iex> create_page_visitor(%{field: value})
      {:ok, %PageVisitor{}}

      iex> create_page_visitor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_page_visitor(attrs \\ %{}) do
    %PageVisitor{}
    |> PageVisitor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a page_visitor.

  ## Examples

      iex> update_page_visitor(page_visitor, %{field: new_value})
      {:ok, %PageVisitor{}}

      iex> update_page_visitor(page_visitor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_page_visitor(%PageVisitor{} = page_visitor, attrs) do
    page_visitor
    |> PageVisitor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a page_visitor.

  ## Examples

      iex> delete_page_visitor(page_visitor)
      {:ok, %PageVisitor{}}

      iex> delete_page_visitor(page_visitor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_page_visitor(%PageVisitor{} = page_visitor) do
    Repo.delete(page_visitor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking page_visitor changes.

  ## Examples

      iex> change_page_visitor(page_visitor)
      %Ecto.Changeset{data: %PageVisitor{}}

  """
  def change_page_visitor(%PageVisitor{} = page_visitor, attrs \\ %{}) do
    PageVisitor.changeset(page_visitor, attrs)
  end

  alias United.Settings.CustomerOrder

  @doc """
  Returns the list of customer_orders.

  ## Examples

      iex> list_customer_orders()
      [%CustomerOrder{}, ...]

  """
  def list_customer_orders do
    Repo.all(CustomerOrder)
  end

  @doc """
  Gets a single customer_order.

  Raises `Ecto.NoResultsError` if the Customer order does not exist.

  ## Examples

      iex> get_customer_order!(123)
      %CustomerOrder{}

      iex> get_customer_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_customer_order!(id), do: Repo.get!(CustomerOrder, id)

  @doc """
  Creates a customer_order.

  ## Examples

      iex> create_customer_order(%{field: value})
      {:ok, %CustomerOrder{}}

      iex> create_customer_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_customer_order(attrs \\ %{}) do
    %CustomerOrder{}
    |> CustomerOrder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a customer_order.

  ## Examples

      iex> update_customer_order(customer_order, %{field: new_value})
      {:ok, %CustomerOrder{}}

      iex> update_customer_order(customer_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_customer_order(%CustomerOrder{} = customer_order, attrs) do
    customer_order
    |> CustomerOrder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a customer_order.

  ## Examples

      iex> delete_customer_order(customer_order)
      {:ok, %CustomerOrder{}}

      iex> delete_customer_order(customer_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_customer_order(%CustomerOrder{} = customer_order) do
    Repo.delete(customer_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking customer_order changes.

  ## Examples

      iex> change_customer_order(customer_order)
      %Ecto.Changeset{data: %CustomerOrder{}}

  """
  def change_customer_order(%CustomerOrder{} = customer_order, attrs \\ %{}) do
    CustomerOrder.changeset(customer_order, attrs)
  end

  alias United.Settings.CustomerOrderLine

  @doc """
  Returns the list of customer_order_lines.

  ## Examples

      iex> list_customer_order_lines()
      [%CustomerOrderLine{}, ...]

  """
  def list_customer_order_lines do
    Repo.all(CustomerOrderLine)
  end

  @doc """
  Gets a single customer_order_line.

  Raises `Ecto.NoResultsError` if the Customer order line does not exist.

  ## Examples

      iex> get_customer_order_line!(123)
      %CustomerOrderLine{}

      iex> get_customer_order_line!(456)
      ** (Ecto.NoResultsError)

  """
  def get_customer_order_line!(id), do: Repo.get!(CustomerOrderLine, id)

  @doc """
  Creates a customer_order_line.

  ## Examples

      iex> create_customer_order_line(%{field: value})
      {:ok, %CustomerOrderLine{}}

      iex> create_customer_order_line(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_customer_order_line(attrs \\ %{}) do
    %CustomerOrderLine{}
    |> CustomerOrderLine.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a customer_order_line.

  ## Examples

      iex> update_customer_order_line(customer_order_line, %{field: new_value})
      {:ok, %CustomerOrderLine{}}

      iex> update_customer_order_line(customer_order_line, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_customer_order_line(%CustomerOrderLine{} = customer_order_line, attrs) do
    customer_order_line
    |> CustomerOrderLine.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a customer_order_line.

  ## Examples

      iex> delete_customer_order_line(customer_order_line)
      {:ok, %CustomerOrderLine{}}

      iex> delete_customer_order_line(customer_order_line)
      {:error, %Ecto.Changeset{}}

  """

  def cg_put_assoc(asc, changeset, params) do
    if params["update_assoc"][asc] == "true" do
      changeset
      |> Ecto.Changeset.cast_assoc(String.to_atom(asc))
    else
      changeset
    end
  end

  alias United.Settings.Book

  def list_books() do
    Repo.all(Book)
  end

  def get_book!(id) do
    Repo.get!(Book, id)
  end

  def create_book(params \\ %{}) do
    Book.changeset(%Book{}, params)
    |> Ecto.Changeset.cast_assoc(:author)
    |> Ecto.Changeset.cast_assoc(:publisher)
    |> Repo.insert()
  end

  def update_book(book, params) do
    book = book |> Repo.preload([:publisher, :author])

    cg = Book.update_changeset(book, params) |> Repo.update()
    IO.inspect(params)

    case cg do
      {:ok, book} ->
        img_url = params |> Map.get("book_image.img_url")

        if img_url != nil do
          q = from bi in United.Settings.BookImage, where: bi.book_id == ^book.id
          Repo.delete_all(q)

          United.Settings.BookImage.changeset(%United.Settings.BookImage{}, %{
            book_id: book.id,
            img_url: img_url
          })
          |> Repo.insert()
        end

        img_url = params |> Map.get("book_image")

        if img_url != nil do
          q = from bi in United.Settings.BookImage, where: bi.book_id == ^book.id
          Repo.delete_all(q)

          bi_params = %{
            group: "cover",
            book_id: book.id,
            img_url: params["book_image"]["img_url"]
          }

          bi_params = bi_params |> United.upload_file()

          Ecto.Changeset.cast(
            %United.Settings.BookImage{},
            bi_params,
            [:book_id, :img_url, :group]
          )
          |> Repo.insert()
        end

      _ ->
        nil
    end

    cg
  end

  def delete_book(%Book{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.Author

  def list_authors() do
    Repo.all(Author)
  end

  def get_author!(id) do
    Repo.get!(Author, id)
  end

  def create_author(params \\ %{}) do
    Author.changeset(%Author{}, params) |> Repo.insert()
  end

  def update_author(book, params) do
    Author.changeset(book, params) |> Repo.update()
  end

  def delete_author(%Author{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.Publisher

  def list_publishers() do
    Repo.all(Publisher)
  end

  def get_publisher!(id) do
    Repo.get!(Publisher, id)
  end

  def create_publisher(params \\ %{}) do
    Publisher.changeset(%Publisher{}, params) |> Repo.insert()
  end

  def update_publisher(model, params) do
    Publisher.changeset(model, params) |> Repo.update()
  end

  def delete_publisher(%Publisher{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.BookCategory

  def list_book_categories() do
    Repo.all(BookCategory)
  end

  def get_book_category!(id) do
    Repo.get!(BookCategory, id)
  end

  def create_book_category(params \\ %{}) do
    BookCategory.changeset(%BookCategory{}, params)
    |> Repo.insert()
  end

  def update_book_category(model, params) do
    BookCategory.changeset(model, params) |> Repo.update()
  end

  def delete_book_category(%BookCategory{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.Loan

  def list_loans() do
    Repo.all(Loan)
  end

  def get_loan!(id) do
    Repo.get!(Loan, id)
  end

  def create_loan(params \\ %{}) do
    reservation = Map.get(params, :reservation, nil)
    a = Loan.changeset(%Loan{}, params) |> Repo.insert()

    case a do
      {:ok, l} ->
        if reservation != nil do
          United.Settings.update_reservation(reservation, %{status: :loaned, loan_id: l.id})
        end

      _ ->
        nil
    end

    a
  end

  def update_loan(model, params) do
    Loan.changeset(model, params) |> Repo.update()
  end

  def delete_loan(%Loan{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.Member

  def list_members() do
    Repo.all(Member)
  end

  def list_members_by_organization_id(organization_id) do
    Repo.all(from m in Member, where: m.organization_id == ^organization_id)
  end

  def get_member!(id) do
    Repo.get!(Member, id)
  end

  def create_member(params \\ %{}) do
    Member.changeset(%Member{}, params) |> Repo.insert()
  end

  def update_member(model, params) do
    Member.changeset(model, params) |> Repo.update()
  end

  def lazy_get_member(email, name, uid, organization_id) do
    member = Repo.get_by(Member, email: email, crypted_password: uid)

    assign_month_year = fn member ->
      Map.put(member, :year, member.inserted_at.year)
      |> Map.put(:month, member.inserted_at.month)
    end

    default_group =
      United.Settings.list_groups() |> Enum.filter(&(&1.name == "会友")) |> List.first()

    default_group =
      if default_group == nil do
        {:ok, df} =
          United.Settings.create_group(%{
            name: "会友",
            loan_limit: 1,
            loan_period: 14,
            extension_period: 14,
            organization_id: organization_id
          })

        df
      else
        default_group
      end

    if member == nil do
      tcount =
        United.Settings.list_members_by_organization_id(organization_id)
        |> Enum.map(&(&1 |> assign_month_year.()))
        # |> Enum.filter(&(&1.year == Date.utc_today().year))
        # |> Enum.filter(&(&1.month == Date.utc_today().month))
        |> Enum.count()

      month = Date.utc_today().month

      m_idx =
        (100 + month)
        |> Integer.to_string()
        |> String.split("")
        |> Enum.reject(&(&1 == ""))
        |> Enum.reverse()
        |> Enum.take(2)
        |> Enum.reverse()
        |> Enum.join("")

      idx =
        (1000 + tcount + 1)
        |> Integer.to_string()
        |> String.split("")
        |> Enum.reject(&(&1 == ""))
        |> Enum.reverse()
        |> Enum.take(3)
        |> Enum.reverse()
        |> Enum.join("")

      create_member(%{
        group_id: default_group.id,
        phone: "n/a",
        ic: "n/a",
        code: "#{Date.utc_today().year}#{m_idx}-#{idx}",
        name: name,
        email: email,
        psid: uid,
        crypted_password: uid,
        organization_id: organization_id
      })
    else
      update_member(member, %{name: name})
    end
  end

  def delete_member(%Member{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.BookImage

  def list_book_images() do
    Repo.all(BookImage)
  end

  def get_book_image!(id) do
    Repo.get!(BookImage, id)
  end

  def create_book_image(params \\ %{}) do
    BookImage.changeset(%BookImage{}, params) |> Repo.insert()
  end

  def update_book_image(model, params) do
    BookImage.changeset(model, params) |> Repo.update()
  end

  def delete_book_image(%BookImage{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.Group

  def list_groups() do
    Repo.all(Group)
  end

  def get_group!(id) do
    Repo.get!(Group, id)
  end

  def create_group(params \\ %{}) do
    Group.changeset(%Group{}, params) |> Repo.insert()
  end

  def update_group(model, params) do
    Group.changeset(model, params) |> Repo.update()
  end

  def delete_group(%Group{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.BookUpload

  def list_book_uploads() do
    Repo.all(BookUpload)
  end

  def get_book_upload!(id) do
    Repo.get!(BookUpload, id)
  end

  def create_book_upload(params \\ %{}) do
    BookUpload.changeset(%BookUpload{}, params) |> Repo.insert()
  end

  def update_book_upload(model, params) do
    BookUpload.changeset(model, params) |> Repo.update()
  end

  def delete_book_upload(%BookUpload{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.BookInventory

  def list_book_inventories() do
    Repo.all(BookInventory)
  end

  def search_member(params, strict \\ false) do
    q =
      from(m in Member,
        left_join: g in Group,
        on: g.id == m.group_id,
        where: ilike(m.code, ^"%#{params["member_code"]}%"),
        preload: [:group]
      )

    q =
      if strict do
        q
      else
        q
        |> or_where([m, g], ilike(m.name, ^"%#{params["member_code"]}%"))
        |> or_where([m, g], ilike(m.ic, ^"%#{params["member_code"]}%"))
        |> or_where([m, g], ilike(m.phone, ^"%#{params["member_code"]}%"))
      end

    Repo.all(q)
  end

  def strong_search_book_inventory(query) do
    q =
      from(bi in BookInventory,
        left_join: b in Book,
        on: b.id == bi.book_id,
        left_join: a in Author,
        on: a.id == b.author_id,
        left_join: p in Publisher,
        on: p.id == b.publisher_id,
        left_join: c in BookCategory,
        on: c.id == bi.book_category_id,
        where: ilike(bi.code, ^"%#{query}%"),
        preload: [:loans, :author, :publisher, :book_category, :book, :book_images],
        limit: 10
      )
      |> or_where([bi, b, a, p, c], ilike(b.isbn, ^"%#{query}%"))
      |> or_where([bi, b, a, p, c], ilike(b.call_number, ^"%#{query}%"))
      |> or_where([bi, b, a, p, c], ilike(b.title, ^"%#{query}%"))
      |> or_where([bi, b, a, p, c], ilike(a.name, ^"%#{query}%"))
      |> or_where([bi, b, a, p, c], ilike(p.name, ^"%#{query}%"))

    Repo.all(q)
  end

  def search_book_inventory(params, strict \\ false) do
    if params["barcode"] == "" do
      []
    else
      q =
        from(bi in BookInventory,
          left_join: b in Book,
          on: b.id == bi.book_id,
          left_join: a in Author,
          on: a.id == b.author_id,
          left_join: p in Publisher,
          on: p.id == b.publisher_id,
          left_join: c in BookCategory,
          on: c.id == bi.book_category_id,
          where: ilike(bi.code, ^"%#{params["barcode"]}%"),
          preload: [:book, :author, :publisher, :book_category]
        )
        |> or_where([bi, b, a, p, c], ilike(b.isbn, ^"%#{params["barcode"]}%"))

      q =
        if strict do
          q
        else
          q
          |> or_where([bi, b, a, p, c], ilike(b.call_number, ^"%#{params["barcode"]}%"))
          |> or_where([bi, b, a, p, c], ilike(b.title, ^"%#{params["barcode"]}%"))
          |> or_where([bi, b, a, p, c], ilike(a.name, ^"%#{params["barcode"]}%"))
          |> or_where([bi, b, a, p, c], ilike(p.name, ^"%#{params["barcode"]}%"))
        end

      Repo.all(q)
    end
  end

  def get_book_inventory!(id) do
    Repo.get!(BookInventory, id)
  end

  def create_book_inventory(params \\ %{}) do
    # rewrite the code here

    res =
      if "update_assoc" in Map.keys(params) do
        assocs = Map.keys(params["update_assoc"])
        cols = BluePotion.test_module("BookInventory") |> Map.keys()

        p = BluePotion.string_to_atom(params, Map.keys(params)) |> Map.delete(:id)

        data = Ecto.Changeset.cast(%BookInventory{}, p, cols)

        {:ok, res} =
          Multi.new()
          |> Multi.run(:book_inventory, fn _repo, %{} ->
            Enum.reduce(assocs, data, fn x, acc -> cg_put_assoc(x, acc, params) end)
            |> Repo.insert()
          end)
          |> Multi.run(:author, fn _repo, %{book_inventory: book_inventory} ->
            author =
              Repo.all(from a in Author, where: a.name == ^params["author"]["name"])
              |> List.first()

            author =
              if author == nil do
                {:ok, author} = create_author(%{name: params["author"]["name"]})
                author
              else
                author
              end

            Book.update_changeset(book_inventory.book, %{author_id: author.id})
            |> Repo.update()
          end)
          |> Multi.run(:publisher, fn _repo, %{book_inventory: book_inventory} ->
            publisher =
              Repo.all(from p in Publisher, where: p.name == ^params["publisher"]["name"])
              |> List.first()

            publisher =
              if publisher == nil do
                {:ok, publisher} = create_publisher(%{name: params["publisher"]["name"]})
                publisher
              else
                publisher
              end

            Book.update_changeset(book_inventory.book, %{publisher_id: publisher.id})
            |> Repo.update()
          end)
          |> Multi.run(:book, fn _repo, %{book_inventory: book_inventory} ->
            # Enum.reduce(assocs, data, fn x, acc -> cg_put_assoc(x, acc, params) end)
            # |> Repo.update()

            if "book_image.img_url" in Map.keys(params) do
              filename =
                params["book_image.img_url"]
                |> String.replace("/images/uploads", "")

              # United.s3_large_upload(filename)

              Repo.delete_all(
                from i in BookImage,
                  where: i.book_id == ^book_inventory.book.id and is_nil(i.group)
              )

              Repo.delete_all(
                from i in BookImage,
                  where: i.book_id == ^book_inventory.book.id and i.group == ^"cover"
              )

              Ecto.Changeset.cast(
                %BookImage{},
                %{
                  group: "cover",
                  book_id: book_inventory.book.id,
                  img_url: params["book_image.img_url"]
                },
                [:book_id, :img_url, :group]
              )
              |> Repo.insert()
            else
              {:ok, nil}
            end
          end)
          |> Repo.transaction()

        {:ok, res.book_inventory}
      else
        BookInventory.changeset(%BookInventory{}, params)
        |> Ecto.Changeset.cast_assoc(:book)
        |> Ecto.Changeset.cast_assoc(:book_category)
        |> Repo.insert()
      end

    United.Settings.repopulate_categories()

    res
  end

  def plan do
    # list_res = exist_on_s3.(bi.img_url)

    #       if list_res != [] do
    #         United.Settings.BookImage.changeset(bi, %{
    #           img_url: "/images/uploads#{hd(list_res)}"
    #         })
    #         |> Repo.update()
    #       else
    #         nil
    #       end
    # United.Settings.BookImage.changeset(bi, %{
    #   img_url: "/images/uploads/bg.jpg"
    # })
    # |> Repo.update()
  end

  def replace_to_default() do
    q = from(bi in United.Settings.BookImage)
    bis = Repo.all(q)

    exist_on_s3 = fn fl ->
      path = "/united/media"
      fl = String.replace(fl, "/images/uploads", "")
      url2_list = fl |> String.split(".")
      take = Enum.count(url2_list)
      variants = ["webp"]

      for item <- variants do
        final_url =
          Enum.take(url2_list, take - 1)
          |> List.insert_at(take, item)
          |> Enum.join(".")

        res =
          "https://damien-bucket.ap-south-1.linodeobjects.com#{final_url |> URI.encode()}"
          |> HTTPoison.get()

        case res do
          {:ok, %{body: body, status_code: 200} = resp} ->
            resp.body
            p = path <> final_url
            IO.inspect(p)
            File.write(p, body)
            final_url

          _ ->
            nil
        end
      end
      |> Enum.reject(&(&1 == nil))
    end

    res =
      for bi <- bis do
        case File.read("/united/lib/united-0.1.0/priv/static#{bi.img_url}") do
          {:error, _reason} ->
            "#{bi.img_url}"

          _ ->
            nil
        end
      end
  end

  def convert_to_local_webp() do
    q = from(bi in United.Settings.BookImage)
    bis = Repo.all(q)

    for bi <- bis do
      United.Settings.BookImage.changeset(bi, %{
        img_url:
          bi.img_url
          |> String.replace(
            "/united/lib/united-0.1.0/priv/static/",
            ""
          )
      })
      |> Repo.update()
    end
  end

  def convert_to_webp() do
    check = File.exists?(File.cwd!() <> "/media")

    path =
      if check do
        File.cwd!() <> "/media"
      else
        File.mkdir(File.cwd!() <> "/media")
        File.cwd!() <> "/media"
      end

    q = from(bi in BookImage)
    bis = Repo.all(q)

    for bi <- bis do
      img_url = Application.app_dir(:united, "priv/static#{bi.img_url}")
      url2_list = bi.img_url |> String.split(".")
      take = Enum.count(url2_list)
      url3 = Enum.take(url2_list, take - 1) |> List.insert_at(take, "webp") |> Enum.join(".")
      webp_url = Application.app_dir(:united, "priv/static#{url3}")
      %{before: img_url, after: webp_url}
      Porcelain.shell("cwebp -q 50 #{img_url} -o #{webp_url}")
      File.rm_rf(img_url)

      BookImage.changeset(bi, %{
        img_url: webp_url
      })
      |> Repo.update()
    end
  end

  def update_from_linode_to_local() do
    q = from(bi in BookImage)
    bis = Repo.all(q)

    for bi <- bis do
      BookImage.changeset(bi, %{
        img_url:
          bi.img_url
          |> String.replace(
            "https://ap-south-1.linodeobjects.com/damien-bucket/",
            "/images/uploads/"
          )
      })
      |> Repo.update()
    end
  end

  def update_book_inventory(model, params) do
    model = model |> Repo.preload([:book_source, :book_category, :author, book: [:book_images]])

    if "update_assoc" in Map.keys(params) do
      assocs = Map.keys(params["update_assoc"])
      cols = BluePotion.test_module("BookInventory") |> Map.keys()

      p = BluePotion.string_to_atom(params, Map.keys(params))

      data = Ecto.Changeset.cast(model, p, cols)

      # process the image
      # delete from disk
      # upload to s3 params["book_image.img_url"]

      res =
        Multi.new()
        |> Multi.run(:book_inventory, fn _repo, %{} ->
          Enum.reduce(assocs, data, fn x, acc -> cg_put_assoc(x, acc, params) end)
          |> Repo.update()
        end)
        |> Multi.run(:book, fn _repo, %{book_inventory: book_inventory} ->
          # Enum.reduce(assocs, data, fn x, acc -> cg_put_assoc(x, acc, params) end)
          # |> Repo.update()
          if "book_image" in Map.keys(params) do
            Repo.delete_all(
              from i in BookImage,
                where: i.book_id == ^book_inventory.book.id and is_nil(i.group)
            )

            Repo.delete_all(
              from i in BookImage,
                where: i.book_id == ^book_inventory.book.id and i.group == ^"cover"
            )

            bi_params = %{
              group: "cover",
              book_id: book_inventory.book.id,
              img_url: params["book_image"]["img_url"]
            }

            bi_params = bi_params |> United.upload_file()

            Ecto.Changeset.cast(
              %BookImage{},
              bi_params,
              [:book_id, :img_url, :group]
            )
            |> Repo.insert()
          else
            {:ok, nil}
          end

          if "book_image.img_url" in Map.keys(params) do
            Repo.delete_all(
              from i in BookImage,
                where: i.book_id == ^book_inventory.book.id and is_nil(i.group)
            )

            Repo.delete_all(
              from i in BookImage,
                where: i.book_id == ^book_inventory.book.id and i.group == ^"cover"
            )

            Ecto.Changeset.cast(
              %BookImage{},
              %{
                group: "cover",
                book_id: book_inventory.book.id,
                img_url: params["book_image.img_url"]
              },
              [:book_id, :img_url, :group]
            )
            |> Repo.insert()
          else
            {:ok, nil}
          end
        end)
        |> Repo.transaction()

      {:ok, multi} = res
      {:ok, multi.book_inventory}
    else
      res = BookInventory.update_changeset(model, params) |> Repo.update()

      case res do
        {:ok, bi} ->
          # search for the similar book and replace it, then delete the newly created book...
          IO.inspect(bi.book)

          if bi.book != nil do
            bres =
              Repo.all(
                from b in Book,
                  where:
                    b.title == ^bi.book.title and b.isbn == ^bi.book.isbn and b.id != ^bi.book.id
              )

            if bres != [] do
              existing_book = List.first(bres)

              with true <- existing_book != nil,
                   true <- existing_book.id < bi.book.id do
                Ecto.Changeset.cast(bi, %{book_id: existing_book.id}, [:book_id]) |> Repo.update()

                Repo.delete(bi.book)
              else
                _ ->
                  nil
              end
            end
          end

          nil

        _ ->
          nil
      end

      res
    end
  end

  def delete_book_inventory(%BookInventory{} = model) do
    Repo.delete(model)
  end

  def book_can_loan(book_inventory_id) do
    Repo.all(
      from l in Loan,
        where:
          l.book_inventory_id == ^book_inventory_id and
            l.has_return == ^false
    )
  end

  def all_outstanding_loans() do
    Repo.all(
      from l in Loan,
        where: l.has_return == ^false,
        preload: [:book, [member: [:group, [organization: :smtp_setting]]]]
    )
  end

  def member_outstanding_loans(member_id) do
    Repo.all(
      from l in Loan,
        where:
          l.member_id == ^member_id and
            l.has_return == ^false,
        preload: [:book, [member: :group]]
    )
  end

  def extend_book(loan_id) do
    l = get_loan!(loan_id) |> Repo.preload(member: :group)

    # check member's member extension period
    # l.member.group.extension_period

    update_loan(l, %{
      has_extended: true,
      return_date: l.return_date |> Timex.shift(days: l.member.group.extension_period)
    })
  end

  def send_available(customer_email, book, visitor) do
    United.Email.available_email(customer_email, book, visitor) |> United.Mailer.deliver_now()
  end

  def return_book_by_barcode(barcode, organization_id) do
    loan_id =
      Repo.all(
        from l in Loan,
          left_join: bi in BookInventory,
          on: l.book_inventory_id == bi.id,
          where: bi.organization_id == ^organization_id,
          where: bi.code == ^barcode and l.has_return == ^false,
          select: l.id
      )
      |> List.first()

    if loan_id != nil do
      l = get_loan!(loan_id) |> Repo.preload([:book, :member])

      m = l.member

      United.Settings.update_member(m, %{has_check_in: false})

      next_reserve =
        Repo.all(
          from r in United.Settings.Reservation,
            where:
              is_nil(r.loan_id) and
                r.book_inventory_id == ^l.book_inventory_id,
            order_by: [asc: r.id],
            preload: [:member]
        )

      if next_reserve != [] do
        r = List.first(next_reserve)
        Elixir.Task.start_link(__MODULE__, :send_available, [r.member.email, l.book, r.member])
        United.Settings.update_reservation(r, %{status: :available})
      end

      update_loan(l, %{has_return: true})
    else
      {:error, nil}
    end
  end

  def return_book(loan_id) do
    l = get_loan!(loan_id) |> Repo.preload([:book, :member])

    m = l.member

    United.Settings.update_member(m, %{has_check_in: false})

    next_reserve =
      Repo.all(
        from r in United.Settings.Reservation,
          where:
            is_nil(r.loan_id) and
              r.book_inventory_id == ^l.book_inventory_id,
          order_by: [asc: r.id],
          preload: [:member]
      )

    if next_reserve != [] do
      r = List.first(next_reserve)
      Elixir.Task.start_link(__MODULE__, :send_available, [r.member.email, l.book, r.member])
      United.Settings.update_reservation(r, %{status: :available})
    end

    update_loan(l, %{has_return: true})
  end

  def setup_book(
        %{
          "AUTHOR" => author_name,
          "BARCODE" => barcode,
          "DESCRIPTION" => description,
          "ISBN" => isbn,
          "PRICE" => price,
          "PUBLISHER" => publisher_name,
          "SOURCE" => source,
          "TITLE" => title
        } = map_d,
        bu,
        organization_id
      ) do
    unless map_d |> Map.values() |> Enum.uniq() |> List.first() == "" do
      s = Repo.all(from a in BookSource, where: a.name == ^source) |> List.first()

      source =
        if s == nil do
          {:ok, s} = create_book_source(%{name: source})
          s
        else
          s
        end

      a = Repo.all(from a in Author, where: a.name == ^author_name) |> List.first()

      author =
        if a == nil do
          {:ok, a} = create_author(%{name: author_name})
          a
        else
          a
        end

      p = Repo.all(from p in Publisher, where: p.name == ^publisher_name) |> List.first()

      publisher =
        if p == nil do
          case create_publisher(%{name: publisher_name}) do
            {:ok, p} ->
              p

            _ ->
              nil
          end
        else
          p
        end

      b = Repo.get_by(Book, title: title, isbn: "#{isbn}")

      book =
        if b == nil do
          price =
            case Float.parse(price) do
              {price, _int} ->
                price

              _ ->
                0.0
            end

          b_cg =
            Ecto.Changeset.cast(
              %Book{},
              %{
                description: description,
                isbn: "#{isbn}",
                call_number: barcode,
                price: price,
                title: title,
                author_id: author.id,
                publisher_id: if(publisher != nil, do: publisher.id)
              },
              [
                :description,
                :title,
                :author_id,
                :publisher_id,
                :call_number,
                :price,
                :isbn
              ]
            )
            |> Repo.insert()
            |> IO.inspect()

          case b_cg do
            {:ok, b} ->
              res =
                Ecto.Changeset.cast(
                  %BookInventory{},
                  %{
                    book_source_id: source.id,
                    book_id: b.id,
                    code: barcode,
                    book_upload_id: bu.id,
                    organization_id: organization_id
                  },
                  [:book_id, :code, :book_upload_id, :organization_id]
                )
                |> Repo.insert()

              case res do
                {:ok, bi} ->
                  {:ok, "book, inventory successful"}

                {:error, bi_cg} ->
                  {reason, message} = bi_cg.errors |> hd()
                  {proper_message, message_list} = message
                  final_reason = Atom.to_string(reason) <> " " <> proper_message
                  {:error, "inventory error - #{final_reason}", map_d}
              end

            {:error, b_cg} ->
              {reason, message} = b_cg.errors |> hd()
              {proper_message, message_list} = message
              final_reason = Atom.to_string(reason) <> " " <> proper_message
              {:error, "book error - #{final_reason}", map_d}
          end
        else
          b

          bi = Repo.get_by(BookInventory, book_id: b.id, code: barcode)

          if bi == nil do
            res =
              Ecto.Changeset.cast(
                %BookInventory{},
                %{
                  book_source_id: source.id,
                  book_id: b.id,
                  code: barcode,
                  book_upload_id: bu.id,
                  organization_id: organization_id
                },
                [:book_id, :code, :book_source_id, :book_upload_id, :organization_id]
              )
              |> Repo.insert()

            case res do
              {:ok, bi} ->
                {:ok, "book, inventory successful"}

              {:error, bi_cg} ->
                {reason, message} = bi_cg.errors |> hd()
                {proper_message, message_list} = message
                final_reason = Atom.to_string(reason) <> " " <> proper_message
                {:error, "inventory error  - #{final_reason}", map_d}
            end
          else
            {:error, "book inventory already exist", map_d}
          end
        end
    end
  end

  def setup_book(
        %{
          "AUTHOR" => author_name,
          "BARCODE" => barcode,
          "BOOK NO" => _empty1,
          "CALL NO" => _empty2,
          "CATEGORY NAME" => _empty3,
          "COAUTHOR" => coauthor_name,
          "DESCRIPTION" => description,
          "ILLUSTRATOR" => illustrator_name,
          "ISBN" => isbn,
          "PRICE" => _empty4,
          "PUBLISHER" => publisher_name,
          "PURCHASE DATE" => _empty5,
          "PURHCHASE INVOICE" => _empty6,
          "SERIES" => series_name,
          "TITLE" => title,
          "TRANSLATOR" => translator_name,
          "VOLUME" => _empty8
        } = map_d,
        bu,
        organization_id
      ) do
    unless map_d |> Map.values() |> Enum.uniq() |> List.first() == "" do
      a = Repo.get_by(Author, name: author_name)

      author =
        if a == nil do
          {:ok, a} = create_author(%{name: author_name})
          a
        else
          a
        end

      p = Repo.get_by(Publisher, name: publisher_name)

      publisher =
        if p == nil do
          case create_publisher(%{name: publisher_name}) do
            {:ok, p} ->
              p

            _ ->
              nil
          end
        else
          p
        end

      b = Repo.get_by(Book, title: title, isbn: "#{isbn}")

      book =
        if b == nil do
          b_cg =
            Ecto.Changeset.cast(
              %Book{},
              %{
                description: description,
                isbn: "#{isbn}",
                call_number: barcode,
                title: title,
                author_id: author.id,
                publisher_id: if(publisher != nil, do: publisher.id)
              },
              [:description, :title, :author_id, :publisher_id, :call_number, :isbn]
            )
            |> Repo.insert()

          case b_cg do
            {:ok, b} ->
              res =
                Ecto.Changeset.cast(
                  %BookInventory{},
                  %{
                    book_id: b.id,
                    code: barcode,
                    book_upload_id: bu.id,
                    organization_id: organization_id
                  },
                  [:book_id, :code, :book_upload_id, :organization_id]
                )
                |> Repo.insert()

              case res do
                {:ok, bi} ->
                  {:ok, "book, inventory successful"}

                {:error, bi_cg} ->
                  {reason, message} = bi_cg.errors |> hd()
                  {proper_message, message_list} = message
                  final_reason = Atom.to_string(reason) <> " " <> proper_message
                  {:error, "inventory error - #{final_reason}", map_d}
              end

            {:error, b_cg} ->
              {reason, message} = b_cg.errors |> hd()
              {proper_message, message_list} = message
              final_reason = Atom.to_string(reason) <> " " <> proper_message
              {:error, "book error - #{final_reason}", map_d}
          end
        else
          b

          bi = Repo.get_by(BookInventory, book_id: b.id, code: barcode)

          if bi == nil do
            res =
              Ecto.Changeset.cast(
                %BookInventory{},
                %{
                  book_id: b.id,
                  code: barcode,
                  book_upload_id: bu.id,
                  organization_id: organization_id
                },
                [:book_id, :code, :book_upload_id, :organization_id]
              )
              |> Repo.insert()

            case res do
              {:ok, bi} ->
                {:ok, "book, inventory successful"}

              {:error, bi_cg} ->
                {reason, message} = bi_cg.errors |> hd()
                {proper_message, message_list} = message
                final_reason = Atom.to_string(reason) <> " " <> proper_message
                {:error, "inventory error  - #{final_reason}", map_d}
            end
          else
            {:error, "book inventory already exist", map_d}
          end
        end
    end
  end

  def setup_book(params, bu, organization_id) do
    IO.inspect(params)

    {:error, "unknown error", params}
  end

  def upload_books(data, bu, organization_id) do
    upload_lines =
      for map_d <- data do
        m =
          map_d
          |> Map.take([
            "AUTHOR",
            "BARCODE",
            "SOURCE",
            "DESCRIPTION",
            "ISBN",
            "PRICE",
            "PUBLISHER",
            "TITLE"
          ])

        setup_book(m, bu, organization_id)
      end
      |> Enum.reject(&(&1 == nil))
      |> List.flatten()

    success = upload_lines |> Enum.reject(&(&1 |> elem(0) == :error))

    failed_lines = upload_lines |> Enum.filter(&(&1 |> elem(0) == :error))

    failed_lines =
      for {:error, reason, map} <- failed_lines do
        Map.put(map, "REASON", reason)
      end

    United.Settings.repopulate_categories()

    update_book_upload(bu, %{
      organization_id: organization_id,
      failed_qty: Enum.count(failed_lines),
      uploaded_qty: Enum.count(success),
      failed_lines: Jason.encode!(failed_lines)
    })
  end

  def reset_all() do
    Repo.delete_all(Publisher)
    Repo.delete_all(Author)
    Repo.delete_all(Book)
    Repo.delete_all(BookInventory)
    Repo.delete_all(Loan)
    Repo.delete_all(BookUpload)
  end

  def reset_books() do
    Repo.delete_all(BookInventory)
    Repo.delete_all(Loan)
    Repo.delete_all(BookUpload)
  end

  def get_member_by_name(uid) do
    Repo.all(from m in Member, where: ilike(m.name, ^"%#{uid}%"), preload: [:group], limit: 5)
  end

  def get_member_by_uid(uid) do
    Repo.all(from m in Member, where: m.psid == ^uid, limit: 1) |> List.first()
  end

  def get_member_by_email(email) do
    Repo.all(from m in Member, where: m.email == ^email, limit: 1) |> List.first()
  end

  def member_token2(id) do
    Phoenix.Token.sign(
      UnitedWeb.Endpoint,
      "signature",
      %{id: id}
    )
  end

  def member_token(id) do
    Phoenix.Token.sign(
      UnitedWeb.Endpoint,
      "member_signature",
      %{id: id}
    )
  end

  def decode_token(token) do
    case Phoenix.Token.verify(UnitedWeb.Endpoint, "signature", token) do
      {:ok, map} ->
        map

      {:error, _reason} ->
        nil
    end
  end

  def decode_member_token2(token) do
    case Phoenix.Token.verify(UnitedWeb.Endpoint, "signature", token) do
      {:ok, map} ->
        map

      {:error, _reason} ->
        nil
    end
  end

  def decode_member_token(token) do
    case Phoenix.Token.verify(UnitedWeb.Endpoint, "member_signature", token) do
      {:ok, map} ->
        map

      {:error, _reason} ->
        nil
    end
  end

  def verify_member_token(token, id) do
    {:ok, map} = Phoenix.Token.verify(UnitedWeb.Endpoint, "member_signature", token)
    map.id == id
  end

  def get_intro_books() do
    Repo.all(
      from bi in BookImage,
        left_join: b in Book,
        on: b.id == bi.book_id,
        left_join: i in BookInventory,
        on: i.book_id == b.id,
        preload: [:publisher, :author, book: [:author, :publisher]]
    )
  end

  def get_book_by_isbn(isbn) do
    a =
      Repo.all(from b in Book, where: b.isbn == ^isbn, preload: [:author, :publisher])
      |> List.first()

    if a != nil do
      a |> BluePotion.s_to_map()
    else
      nil
    end
  end

  def repopulate_categories() do
    # go through each book_inventory,
    # assign the category
    # import Ecto.Query
    # United.Repo.delete_all(from bc in United.Settings.BookCategory, where: is_nil(bc.name))

    ors = Repo.all(from(o in United.Settings.Organization))

    for org <- ors do
      if Process.whereis("bc_kv_#{org.id}" |> String.to_atom()) == nil do
        {:ok, pid} = Agent.start_link(fn -> %{} end)
        Process.register(pid, "bc_kv_#{org.id}" |> String.to_atom())

        IO.inspect("bc_kv kv created")
      else
        IO.inspect("bc_kv kv exist")
      end
    end

    for org <- ors do
      bc_kv = Agent.get(Process.whereis("bc_kv_#{org.id}" |> String.to_atom()), fn map -> map end)
    end

    bcs = Repo.all(from bc in BookCategory, where: not is_nil(bc.organization_id))

    kv =
      for bci <- bcs do
        Agent.update(
          Process.whereis("bc_kv_#{bci.organization_id}" |> String.to_atom()),
          fn map -> Map.put(map, bci.code, bci) end
        )
      end

    # bi_list = Repo.all(from(bi in BookInventory, where: not is_nil(bi.code)))

    bi_list_group =
      Repo.all(from(bi in BookInventory, where: not is_nil(bi.code)))
      |> Enum.group_by(& &1.organization_id)

    orgs = Map.keys(bi_list_group) |> Enum.reject(&(&1 == nil)) |> IO.inspect()

    for org_id <- orgs do
      bi_list = bi_list_group |> Map.get(org_id)

      final_bi =
        for bi <- bi_list do
          # check the code, and create the category
          IO.inspect(bi.code)

          code =
            bi.code
            |> String.split("")
            |> Enum.reject(&(&1 == ""))
            |> Enum.take(2)
            |> Enum.join("")

          IO.inspect(code)
          # book_code = Repo.get_by(BookCategory, code: code)
          book_code =
            Agent.get(Process.whereis("bc_kv_#{org_id}" |> String.to_atom()), fn map ->
              map |> Map.get(code)
            end)

          bcategory =
            if book_code == nil do
              {:ok, bci} = create_book_category(%{code: code, organization_id: org_id})

              Agent.update(Process.whereis("bc_kv_#{org_id}" |> String.to_atom()), fn map ->
                Map.put(map, bci.code, bci)
              end)

              bci
            else
              book_code
            end

          update_book_inventory(bi, %{book_category_id: bcategory.id})

          if bi.book_category_id == nil do
          else
            #
            nil
          end

          bcategory
        end
        |> Enum.group_by(& &1)

      keys = Map.keys(final_bi)

      for key <- keys do
        update_book_category(key, %{book_count: Enum.count(final_bi[key])})
      end
    end
  end

  alias United.Settings.BookTag

  def list_book_tags() do
    Repo.all(BookTag)
  end

  def get_book_tag!(id) do
    Repo.get!(BookTag, id)
  end

  def create_book_tag(params \\ %{}) do
    BookTag.changeset(%BookTag{}, params) |> Repo.insert()
  end

  def update_book_tag(model, params) do
    BookTag.changeset(model, params) |> Repo.update()
  end

  def delete_book_tag(%BookTag{} = model) do
    Repo.delete(model)
  end

  def get_tag_books(params) do
    Repo.all(
      from bi in BookInventory,
        left_join: bt in BookTag,
        on: bt.book_inventory_id == bi.id,
        left_join: t in Tag,
        on: t.id == bt.tag_id,
        where: t.name == ^params["tag"],
        preload: [:book, :book_images, :author, :publisher, :book_category]
    )
  end

  def book_data(params) do
    Repo.all(
      from bi in BookInventory,
        left_join: bt in BookTag,
        on: bt.book_inventory_id == bi.id,
        left_join: t in Tag,
        on: t.id == bt.tag_id,
        where: bi.id == ^params["bi"],
        preload: [:book, :book_images, :author, :publisher, :book_category]
    )
    |> List.first()
  end

  def remove_bi_to_tag(params) do
    sample = %{"bi" => "8695", "scope" => "assign_bi_to_tag", "tag" => "New"}
    bi = get_book_inventory!(params["bi"])
    tag = Repo.get_by(Tag, name: params["tag"])

    check = Repo.get_by(BookTag, book_inventory_id: bi.id, tag_id: tag.id)

    if check != nil do
      Repo.delete(check)
    end
  end

  def assign_bi_to_tag(params) do
    sample = %{"bi" => "8695", "scope" => "assign_bi_to_tag", "tag" => "New"}
    bi = get_book_inventory!(params["bi"])
    tag = Repo.get_by(Tag, name: params["tag"])

    check = Repo.get_by(BookTag, book_inventory_id: bi.id, tag_id: tag.id)

    if check == nil do
      create_book_tag(%{book_inventory_id: bi.id, tag_id: tag.id})
    end
  end

  alias United.Settings.PageSection

  def list_page_sections() do
    Repo.all(PageSection)
  end

  def get_page_section!(id) do
    Repo.get!(PageSection, id)
  end

  def get_page_section_name(section) do
    Repo.get_by(PageSection, section: section)
  end

  def create_page_section(params \\ %{}) do
    PageSection.changeset(%PageSection{}, params) |> Repo.insert()
  end

  def update_page_section(model, params) do
    PageSection.changeset(model, params) |> Repo.update()
  end

  def delete_page_section(%PageSection{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.EmailReminder

  def list_email_reminders() do
    Repo.all(EmailReminder)
  end

  def get_email_reminder!(id) do
    Repo.get!(EmailReminder, id)
  end

  def create_email_reminder(params \\ %{}) do
    EmailReminder.changeset(%EmailReminder{}, params) |> Repo.insert()
  end

  def update_email_reminder(model, params) do
    EmailReminder.changeset(model, params) |> Repo.update()
  end

  def delete_email_reminder(%EmailReminder{} = model) do
    Repo.delete(model)
  end

  def check_in(qrcode) do
    ms = Repo.all(from m in Member, where: m.qrcode == ^qrcode)
    member = List.first(ms)

    if member != nil do
      update_member(member, %{has_check_in: true})
    end
  end

  def check_out(qrcode) do
    ms = Repo.all(from m in Member, where: m.qrcode == ^qrcode)
    member = List.first(ms)

    if member != nil do
      update_member(member, %{has_check_in: false})
    end
  end

  def statistic(params) do
    title = Map.get(params, "title", "loan_history_by_month")

    year = Map.get(params, "year", "2022")
    syear = NaiveDateTime.from_erl!({{String.to_integer(year), 1, 1}, {0, 0, 0}})
    eyear = Timex.shift(syear, years: 1)

    sdate = Map.get(params, "sdate", NaiveDateTime.utc_now() |> Timex.shift(months: -1))
    edate = Map.get(params, "edate", NaiveDateTime.utc_now())

    months = ~S(JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC) |> String.split(" ")

    case title do
      "new_books_by_category" ->
        q =
          from(iv in BookInventory,
            left_join: c in BookCategory,
            on: c.id == iv.book_category_id,
            where:
              iv.inserted_at > ^syear and
                iv.inserted_at < ^eyear,
            select: %{count: count(iv.id), code: c.code, category: c.name},
            group_by: [
              c.code,
              c.id
            ]
          )

        data = Repo.all(q)

      "new_books_by_month" ->
        q =
          from(iv in BookInventory,
            left_join: c in BookCategory,
            on: c.id == iv.book_category_id,
            where:
              iv.inserted_at > ^syear and
                iv.inserted_at < ^eyear,
            select: %{count: count(iv.id)},
            select_merge: %{
              month: fragment("to_char(date_trunc('month', ?), 'MON')", iv.inserted_at)
            },
            group_by: [fragment("to_char(date_trunc('month', ?), 'MON')", iv.inserted_at)]
          )

        data = Repo.all(q)

        for month <- months do
          res = Enum.filter(data, &(&1.month == month))

          if res != [] do
            List.first(res)
          else
            %{month: month, count: 0}
          end
        end

      "all_loans" ->
        q =
          from l in Loan,
            where:
              l.inserted_at > ^syear and
                l.inserted_at < ^eyear,
            select: %{has_return: l.has_return, count: count(l.has_return)},
            group_by: [l.has_return]

        Repo.all(q)

      "member_join_by_month" ->
        q =
          from(l in Member,
            where:
              l.is_approved == ^true and l.inserted_at > ^syear and
                l.inserted_at < ^eyear,
            select: %{count: count(l.id)},
            select_merge: %{
              month: fragment("to_char(date_trunc('month', ?), 'MON')", l.inserted_at)
            },
            group_by: [fragment("to_char(date_trunc('month', ?), 'MON')", l.inserted_at)]
          )

        data = Repo.all(q)

        for month <- months do
          res = Enum.filter(data, &(&1.month == month))

          if res != [] do
            List.first(res)
          else
            %{month: month, count: 0}
          end
        end

      "loan_history_by_month" ->
        q =
          from(l in Loan,
            where:
              l.has_return == ^true and l.inserted_at > ^syear and
                l.inserted_at < ^eyear,
            select: %{count: count(l.id)},
            select_merge: %{
              month: fragment("to_char(date_trunc('month', ?), 'MON')", l.inserted_at)
            },
            group_by: [fragment("to_char(date_trunc('month', ?), 'MON')", l.inserted_at)]
          )

        data = Repo.all(q)

        for month <- months do
          res = Enum.filter(data, &(&1.month == month))

          if res != [] do
            List.first(res)
          else
            %{month: month, count: 0}
          end
        end

      "loan_history_by_member_month" ->
        q =
          from(l in Loan,
            join: m in Member,
            on: l.member_id == m.id,
            where:
              l.has_return == ^true and l.inserted_at > ^syear and
                l.inserted_at < ^eyear,
            select: %{count: count(m.name), member: m.name},
            select_merge: %{
              month: fragment("to_char(date_trunc('month', ?), 'MON')", l.inserted_at)
            },
            group_by: [m.name, fragment("to_char(date_trunc('month', ?), 'MON')", l.inserted_at)],
            order_by: [desc: count(m.name)]
          )

        Repo.all(q)

      "loan_history_by_member_week" ->
        # Timex.iso_week(Date.utc_today |> Timex.shift(weeks: -1))

        append_week_number = fn map ->
          {_year, week} =
            Timex.iso_week(map |> Map.get(:inserted_at) |> Timex.shift(days: 2, hours: 6))

          %{week_number: week} |> Map.merge(map)
        end

        q =
          from(l in Loan,
            join: m in Member,
            on: l.member_id == m.id,
            where: l.has_return == ^true,
            where:
              l.inserted_at > ^sdate and
                l.inserted_at < ^edate,
            select: %{member: m.name, inserted_at: l.inserted_at}
          )

        data =
          Repo.all(q)
          |> Enum.map(&(&1 |> append_week_number.()))
          |> Enum.group_by(& &1.week_number)

        res = Map.keys(data)

        hd =
          if res != [] do
            List.first(res)
          else
            0
          end

        # tl = List.last(res)
        tl = hd + 3

        for r <- hd..tl do
          count =
            if data[r] != nil do
              data[r] |> Enum.count()
            else
              0
            end

          l =
            if data[r] != nil do
              list = data[r] |> Enum.group_by(& &1.member)

              l_keys = Map.keys(list)

              for l_key <- l_keys do
                %{member: l_key, count: Enum.count(list[l_key])}
              end
            else
              []
            end

          %{week_number: r, count: count, list: l}
        end

      "loan_history_by_member" ->
        q =
          from(l in Loan,
            join: m in Member,
            on: l.member_id == m.id,
            where:
              l.has_return == ^true and l.inserted_at > ^syear and
                l.inserted_at < ^eyear,
            select: %{count: count(m.name), member: m.name},
            group_by: [m.name],
            order_by: [desc: count(m.name)]
          )

        Repo.all(q)

      "loan_history_by_category" ->
        q =
          from(l in Loan,
            left_join: bi in BookInventory,
            on: l.book_inventory_id == bi.id,
            left_join: c in BookCategory,
            on: c.id == bi.book_category_id,
            where:
              l.has_return == ^true and l.inserted_at > ^syear and
                l.inserted_at < ^eyear,
            select: %{count: count(c.code), code: c.code, category: c.name},
            group_by: [c.code, c.id],
            order_by: [desc: count(c.code)]
          )

        Repo.all(q)

      "loan_history_by_category_month" ->
        q =
          from(l in Loan,
            left_join: bi in BookInventory,
            on: l.book_inventory_id == bi.id,
            left_join: c in BookCategory,
            on: c.id == bi.book_category_id,
            where: l.has_return == ^true,
            where:
              l.inserted_at > ^syear and
                l.inserted_at < ^eyear,
            select: %{count: count(c.code), code: c.code, category: c.name},
            select_merge: %{
              month: fragment("to_char(date_trunc('month', ?), 'MON')", l.inserted_at)
            },
            group_by: [
              fragment("to_char(date_trunc('month', ?), 'MON')", l.inserted_at),
              c.code,
              c.id
            ],
            order_by: [desc: count(c.code)]
          )

        categories = United.Settings.list_book_categories()

        res = Repo.all(q) |> Enum.group_by(& &1.month)

        for cat <- categories do
          data =
            for month <- months do
              category_data = res[month]

              with true <- category_data != nil,
                   cat_res <-
                     Enum.filter(category_data, &(&1.code == cat.code)) |> List.first(),
                   true <- cat_res != nil do
                cat_res |> Map.take([:month, :count])
              else
                _ ->
                  %{month: month, count: 0}
              end
            end

          %{category: cat.name, code: cat.code, data: data}
        end

      _ ->
        %{}
    end
  end

  alias United.Settings.Holiday

  def list_holidays() do
    Repo.all(Holiday) |> IO.inspect()
  end

  def get_holiday!(id) do
    Repo.get!(Holiday, id)
  end

  def get_holiday_by_date(date) do
    Repo.all(from h in Holiday, where: h.event_date == ^date) |> List.first()
  end

  def create_holiday(params \\ %{}) do
    Holiday.changeset(%Holiday{}, params) |> Repo.insert()
  end

  def update_holiday(model, params) do
    Holiday.changeset(model, params) |> Repo.update()
  end

  def delete_holiday(%Holiday{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.Reservation

  def list_reservations() do
    Repo.all(Reservation)
  end

  def get_reservation!(id) do
    Repo.get!(Reservation, id)
  end

  def check_reservation(%{member_id: member_id, book_inventory_id: book_inventory_id} = attrs) do
    check =
      Repo.all(
        from r in Reservation,
          where:
            is_nil(r.loan_id) and r.member_id == ^member_id and
              r.book_inventory_id == ^book_inventory_id
      )

    check == []
  end

  def create_reservation(params \\ %{}) do
    Reservation.changeset(%Reservation{}, params) |> Repo.insert()
  end

  def update_reservation(model, params) do
    Reservation.changeset(model, params) |> Repo.update()
  end

  def delete_reservation(%Reservation{} = model) do
    Repo.delete(model)
  end

  def get_member_outstanding_reservations(member) do
    Repo.all(
      from r in Reservation,
        where: is_nil(r.loan_id) and r.member_id == ^member.id,
        preload: [book_inventory: [:book, :book_category, :book_images]]
    )
  end

  def is_next_reserved_member(member, book_inventory) do
    check =
      Repo.all(
        from r in Reservation,
          where:
            is_nil(r.loan_id) and
              r.book_inventory_id == ^book_inventory.id,
          order_by: [asc: r.id],
          preload: [:member]
      )

    r = List.first(check)

    if r != nil do
      if r.member_id == member.id do
        %{can_loan: true, reservation: r}
      else
        %{can_loan: false, member: r.member}
      end
    else
      %{can_loan: true, reservation: nil}
    end
  end

  def raw_sql(type \\ "category_month") do
    query1 = """
      select
    to_char( l.inserted_at , 'YYYY') as year,
    bc.code,
    bc.name,
    count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '01') AS jan,
    count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '02') AS feb,
    count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '03') AS mar,
    count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '04') AS apr,
    count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '05') AS may,
    count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '06') AS jun,
    count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '07') AS jul,
    count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '08') AS aug,
    count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '09') AS sep,
    count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '10') AS oct,
    count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '11') AS nov,
    count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '12') AS dev
    from
    loans l
    left join book_inventories bi on
    bi.id = l.book_inventory_id
    left join book_categories bc on
    bi.book_category_id = bc.id group by bc.code, bc.name , to_char( l.inserted_at , 'YYYY') order by to_char( l.inserted_at , 'YYYY') desc ;
    """

    query2 = """
    select
    to_char( l.inserted_at , 'YYYY') as year,

      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '01') AS jan,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '02') AS feb,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '03') AS mar,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '04') AS apr,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '05') AS may,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '06') AS jun,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '07') AS jul,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '08') AS aug,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '09') AS sep,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '10') AS oct,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '11') AS nov,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '12') AS dev
    from
      loans l
    left join members m on l.member_id = m.id

      group by  to_char( l.inserted_at , 'YYYY') order by to_char( l.inserted_at , 'YYYY') desc ;
    """

    query3 = """
    select

    to_char( l.inserted_at , 'YYYY') as year,
    m.name,
    m.email,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '01') AS jan,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '02') AS feb,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '03') AS mar,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '04') AS apr,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '05') AS may,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '06') AS jun,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '07') AS jul,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '08') AS aug,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '09') AS sep,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '10') AS oct,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '11') AS nov,
      count(l.id) FILTER(WHERE to_char( l.inserted_at , 'YYYY') = to_char( l.inserted_at , 'YYYY') and to_char( l.inserted_at , 'MM') = '12') AS dev
    from
      loans l
    left join members m on l.member_id = m.id

      group by  m.name, m.email, to_char( l.inserted_at , 'YYYY') order by to_char( l.inserted_at , 'YYYY') desc ;
    """

    params = []

    query =
      case type do
        "category_month" ->
          query1

        "member_month" ->
          query3

        _ ->
          query2
      end

    result = United.Repo.query(query, params)
  end

  def send_outstanding_emails(%United.Settings.Organization{} = organization) do
    outstanding_reminders =
      Repo.all(
        from er in EmailReminder,
          where: er.status == ^"pending" and er.is_sent == ^false,
          preload: [:member]
      )

    for outstanding_reminder <- outstanding_reminders do
      case United.Email.custom_email(
             outstanding_reminder.member.email,
             "Notice",
             outstanding_reminder.content,
             organization
           )
           |> United.Mailer.send_email_for_org(organization) do
        {:ok, %Bamboo.Email{html_body: html_body} = resp} ->
          nil

          United.Settings.update_email_reminder(outstanding_reminder, %{
            is_sent: true,
            status: "sent"
          })

        _ ->
          nil
      end
    end
  end

  def fix_book() do
    check =
      Repo.all(
        from b in Book,
          full_join: bi in BookInventory,
          on: bi.book_id == b.id,
          select: %{book_id: b.id, book_inventory_id: bi.id}
      )

    create_bi2 = fn map ->
      BookInventory.update_changeset(%BookInventory{}, %{
        book_id: map.book.id,
        code: map.book.call_number
      })
      |> Repo.insert()
    end

    Enum.map(check, &(&1 |> create_bi2.()))
  end

  def decode_admin_token(token) do
    case Phoenix.Token.verify(UnitedWeb.Endpoint, "admin_signature", token) do
      {:ok, map} ->
        map

      {:error, _reason} ->
        nil
    end
  end

  alias United.Settings.SessionUser

  def get_member_by_cookie(cookie) do
    Repo.all(from(s in SessionUser, where: s.cookie == ^cookie))
    |> List.first()
  end

  def get_cookie_user_by_cookie(cookie) do
    Repo.all(
      from(s in SessionUser, where: s.cookie == ^cookie, preload: [user: [role: :app_routes]])
    )
    |> List.first()
  end

  def list_session_users() do
    Repo.all(SessionUser)
  end

  def get_session_user!(id) do
    Repo.get!(SessionUser, id)
  end

  def create_session_user(params \\ %{}) do
    SessionUser.changeset(%SessionUser{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_session_user(model, params) do
    SessionUser.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_session_user(%SessionUser{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.AppRoute

  def list_app_routes() do
    Repo.all(AppRoute)
  end

  def get_app_route!(id) do
    Repo.get!(AppRoute, id)
  end

  def create_app_route(params \\ %{}) do
    bool_key = "can_get"
    params = append_bool_key(params, bool_key)

    bool_key = "can_post"
    params = append_bool_key(params, bool_key)
    name = params["name"]
    check = Repo.all(from(ap in AppRoute, where: ap.name == ^name))

    if check == [] do
      cg = AppRoute.changeset(%AppRoute{}, params) |> Repo.insert() |> IO.inspect()
    else
      {:ok, List.first(check)}
    end
  end

  def update_app_route(model, params) do
    bool_key = "can_get"
    params = append_bool_key(params, bool_key)

    bool_key = "can_post"
    params = append_bool_key(params, bool_key)
    AppRoute.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_app_route(%AppRoute{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.Role

  def list_roles() do
    Repo.all(Role)
  end

  def get_role!(id) do
    Repo.get!(Role, id) |> Repo.preload(:app_routes)
  end

  def create_role(params \\ %{}) do
    Role.changeset(%Role{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_role(model, params) do
    Role.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_role(%Role{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.RoleAppRoute

  def list_role_app_routes() do
    Repo.all(RoleAppRoute)
  end

  def get_role_app_route!(id) do
    Repo.get!(RoleAppRoute, id)
  end

  def create_role_app_route(
        %{"app_route_id" => app_route_ids, "id" => "0", "role_id" => role_id} = _params
      ) do
    Repo.delete_all(from(rap in RoleAppRoute, where: rap.role_id == ^role_id))

    for app_route_id <- app_route_ids |> String.split(",") do
      params = %{"role_id" => role_id, "app_route_id" => app_route_id}
      RoleAppRoute.changeset(%RoleAppRoute{}, params) |> Repo.insert() |> IO.inspect()
    end

    {:ok, %RoleAppRoute{id: 0}}
  end

  def create_role_app_route(%{"AppRoute" => %{} = mapList, "id" => "0"} = params) do
    role_id = Map.keys(params["AppRoute"]) |> List.first()

    items = params["AppRoute"][role_id] |> Map.keys()
    Repo.delete_all(from(rap in RoleAppRoute, where: rap.role_id == ^role_id))

    for item <- items do
      params = %{"role_id" => role_id, "app_route_id" => item}
      RoleAppRoute.changeset(%RoleAppRoute{}, params) |> Repo.insert() |> IO.inspect()
    end

    {:ok, %RoleAppRoute{id: 0}}
  end

  def update_role_app_route(model, params) do
    RoleAppRoute.changeset(model, params) |> Repo.update() |> IO.inspect()
  end

  def delete_role_app_route(%RoleAppRoute{} = model) do
    Repo.delete(model)
  end

  alias United.Settings.Staff

  def list_staffs() do
    Repo.all(Staff)
  end

  def get_staff!(id) do
    Repo.get!(Staff, id)
  end

  def create_staff(params \\ %{}) do
    Staff.changeset(%Staff{}, params) |> Repo.insert() |> IO.inspect()
  end

  def update_staff(model, attrs) do
    attrs =
      with true <- "password" in Map.keys(attrs),
           true <- attrs["password"] != "" do
        crypted_password =
          :crypto.hash(:sha512, attrs["password"]) |> Base.encode16() |> String.downcase()

        attrs |> Map.put("crypted_password", crypted_password)
      else
        _ ->
          attrs
      end

    Staff.changeset(model, attrs) |> Repo.update() |> IO.inspect()
  end

  def delete_staff(%Staff{} = model) do
    Repo.delete(model)
  end

  def check_staff_password(params) do
    users =
      Repo.all(
        from(u in Staff, where: u.username == ^params["username"], preload: [role: :app_routes])
      )
      |> IO.inspect()

    with true <- users != [],
         true <- users != nil do
      user = List.first(users)

      crypted_password =
        :crypto.hash(:sha512, params["password"] |> IO.inspect())
        |> Base.encode16()
        |> String.downcase()
        |> IO.inspect()

      {crypted_password == user.crypted_password, user} |> IO.inspect()
    else
      _ ->
        {false, nil}
    end
  end

  def get_admin_staff() do
    check = Repo.all(from(r in Role, where: r.name == "Owner")) |> IO.inspect()

    if check == [] do
      {:ok, role} = create_role(%{name: "Owner", desc: "own and manage the company "})
      role
    else
      List.first(check)
    end
  end

  def populate_menus(menus) do
    rars = Repo.all(from(r in Role, preload: [:app_routes]))

    Multi.new()
    |> Multi.run(:update, fn _repo, %{} ->
      Repo.delete_all(AppRoute)
      Repo.delete_all(RoleAppRoute)

      for role <- rars do
        for menu <- menus do
          {:ok, route} =
            create_app_route(%{
              "name" => menu |> Map.get("title"),
              "route" => menu |> Map.get("path"),
              "icon" => menu |> Map.get("icon")
            })

          admin_role = get_admin_staff()

          cg =
            RoleAppRoute.changeset(%RoleAppRoute{}, %{
              role_id: role.id,
              app_route_id: route.id
            })

          if role.name == admin_role.name do
            cg
            |> Repo.insert()
          else
            if role.app_routes
               |> Enum.filter(&(&1.route == route.route))
               |> Enum.filter(&(&1.name == route.name)) != [] do
              cg
              |> Repo.insert()
            end
          end

          children = Map.get(menu, "children", %{})

          for child <- children do
            {:ok, croute} =
              create_app_route(%{
                "name" => child |> Map.get("title"),
                "route" => child |> Map.get("path"),
                "icon" => child |> Map.get("icon")
              })

            ccg =
              RoleAppRoute.changeset(%RoleAppRoute{}, %{
                role_id: role.id,
                app_route_id: croute.id
              })

            if role.name == admin_role.name do
              ccg
              |> Repo.insert()
            else
              if role.app_routes
                 |> Enum.filter(&(&1.route == croute.route))
                 |> Enum.filter(&(&1.name == croute.name)) != [] do
                ccg
                |> Repo.insert()
              end
            end
          end
        end
      end

      {:ok, nil}
    end)
    |> Repo.transaction()
  end

  alias United.Settings.SmtpSetting

  def list_smtp_settings() do
    Repo.all(SmtpSetting)
  end

  def get_smtp_setting!(id) do
    Repo.get!(SmtpSetting, id)
  end

  def create_smtp_setting(attrs \\ %{}) do
    attrs =
      if "password" in Map.keys(attrs) do
        crypted_password = attrs["password"] |> United.Encryption.encrypt()
        attrs |> Map.put("crypted_password", crypted_password)
      else
        attrs
      end

    SmtpSetting.changeset(%SmtpSetting{}, attrs) |> Repo.insert()
  end

  def update_smtp_setting(model, attrs) do
    attrs =
      if "password" in Map.keys(attrs) do
        crypted_password = attrs["password"] |> United.Encryption.encrypt()

        attrs |> Map.put("crypted_password", crypted_password)
      else
        attrs
      end

    SmtpSetting.changeset(model, attrs) |> Repo.update()
  end

  def delete_smtp_setting(%SmtpSetting{} = model) do
    Repo.delete(model)
  end

  def reupdate_member_codes(organization_id) do
    # Get all members for the organization ordered by insertion date
    members =
      Repo.all(
        from m in Member,
          where: m.organization_id == ^organization_id,
          order_by: [asc: m.inserted_at]
      )

    # Update each member's code sequentially
    members
    |> Enum.with_index(1)
    |> Enum.each(fn {member, index} ->
      year = member.inserted_at.year
      month = member.inserted_at.month

      # Format month with leading zero
      m_idx =
        (100 + month)
        |> Integer.to_string()
        |> String.split("")
        |> Enum.reject(&(&1 == ""))
        |> Enum.reverse()
        |> Enum.take(2)
        |> Enum.reverse()
        |> Enum.join("")

      # Format sequential number with leading zeros
      idx =
        (1000 + index)
        |> Integer.to_string()
        |> String.split("")
        |> Enum.reject(&(&1 == ""))
        |> Enum.reverse()
        |> Enum.take(3)
        |> Enum.reverse()
        |> Enum.join("")

      # Update the member's code
      United.Settings.update_member(member, %{code: "#{year}#{m_idx}-#{idx}"})
    end)
  end
end
