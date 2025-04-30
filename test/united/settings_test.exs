defmodule United.SettingsTest do
  use United.DataCase

  alias United.Settings

  describe "users" do
    alias United.Settings.User

    @valid_attrs %{
      bio: "some bio",
      crypted_password: "some crypted_password",
      email: "some email",
      full_name: "some full_name",
      name: "some name",
      password: "some password",
      phone: "some phone"
    }
    @update_attrs %{
      bio: "some updated bio",
      crypted_password: "some updated crypted_password",
      email: "some updated email",
      full_name: "some updated full_name",
      name: "some updated name",
      password: "some updated password",
      phone: "some updated phone"
    }
    @invalid_attrs %{
      bio: nil,
      crypted_password: nil,
      email: nil,
      full_name: nil,
      name: nil,
      password: nil,
      phone: nil
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Settings.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Settings.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Settings.create_user(@valid_attrs)
      assert user.bio == "some bio"
      assert user.crypted_password == "some crypted_password"
      assert user.email == "some email"
      assert user.full_name == "some full_name"
      assert user.name == "some name"
      assert user.password == "some password"
      assert user.phone == "some phone"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Settings.update_user(user, @update_attrs)
      assert user.bio == "some updated bio"
      assert user.crypted_password == "some updated crypted_password"
      assert user.email == "some updated email"
      assert user.full_name == "some updated full_name"
      assert user.name == "some updated name"
      assert user.password == "some updated password"
      assert user.phone == "some updated phone"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_user(user, @invalid_attrs)
      assert user == Settings.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Settings.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Settings.change_user(user)
    end
  end

  describe "blogs" do
    alias United.Settings.Blog

    @valid_attrs %{
      author: "some author",
      body: "some body",
      excerpt: "some excerpt",
      title: "some title"
    }
    @update_attrs %{
      author: "some updated author",
      body: "some updated body",
      excerpt: "some updated excerpt",
      title: "some updated title"
    }
    @invalid_attrs %{author: nil, body: nil, excerpt: nil, title: nil}

    def blog_fixture(attrs \\ %{}) do
      {:ok, blog} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_blog()

      blog
    end

    test "list_blogs/0 returns all blogs" do
      blog = blog_fixture()
      assert Settings.list_blogs() == [blog]
    end

    test "get_blog!/1 returns the blog with given id" do
      blog = blog_fixture()
      assert Settings.get_blog!(blog.id) == blog
    end

    test "create_blog/1 with valid data creates a blog" do
      assert {:ok, %Blog{} = blog} = Settings.create_blog(@valid_attrs)
      assert blog.author == "some author"
      assert blog.body == "some body"
      assert blog.excerpt == "some excerpt"
      assert blog.title == "some title"
    end

    test "create_blog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_blog(@invalid_attrs)
    end

    test "update_blog/2 with valid data updates the blog" do
      blog = blog_fixture()
      assert {:ok, %Blog{} = blog} = Settings.update_blog(blog, @update_attrs)
      assert blog.author == "some updated author"
      assert blog.body == "some updated body"
      assert blog.excerpt == "some updated excerpt"
      assert blog.title == "some updated title"
    end

    test "update_blog/2 with invalid data returns error changeset" do
      blog = blog_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_blog(blog, @invalid_attrs)
      assert blog == Settings.get_blog!(blog.id)
    end

    test "delete_blog/1 deletes the blog" do
      blog = blog_fixture()
      assert {:ok, %Blog{}} = Settings.delete_blog(blog)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_blog!(blog.id) end
    end

    test "change_blog/1 returns a blog changeset" do
      blog = blog_fixture()
      assert %Ecto.Changeset{} = Settings.change_blog(blog)
    end
  end

  describe "stored_medias" do
    alias United.Settings.StoredMedia

    @valid_attrs %{
      f_extension: "some f_extension",
      f_type: "some f_type",
      name: "some name",
      s3_url: "some s3_url",
      size: 42
    }
    @update_attrs %{
      f_extension: "some updated f_extension",
      f_type: "some updated f_type",
      name: "some updated name",
      s3_url: "some updated s3_url",
      size: 43
    }
    @invalid_attrs %{f_extension: nil, f_type: nil, name: nil, s3_url: nil, size: nil}

    def stored_media_fixture(attrs \\ %{}) do
      {:ok, stored_media} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_stored_media()

      stored_media
    end

    test "list_stored_medias/0 returns all stored_medias" do
      stored_media = stored_media_fixture()
      assert Settings.list_stored_medias() == [stored_media]
    end

    test "get_stored_media!/1 returns the stored_media with given id" do
      stored_media = stored_media_fixture()
      assert Settings.get_stored_media!(stored_media.id) == stored_media
    end

    test "create_stored_media/1 with valid data creates a stored_media" do
      assert {:ok, %StoredMedia{} = stored_media} = Settings.create_stored_media(@valid_attrs)
      assert stored_media.f_extension == "some f_extension"
      assert stored_media.f_type == "some f_type"
      assert stored_media.name == "some name"
      assert stored_media.s3_url == "some s3_url"
      assert stored_media.size == 42
    end

    test "create_stored_media/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_stored_media(@invalid_attrs)
    end

    test "update_stored_media/2 with valid data updates the stored_media" do
      stored_media = stored_media_fixture()

      assert {:ok, %StoredMedia{} = stored_media} =
               Settings.update_stored_media(stored_media, @update_attrs)

      assert stored_media.f_extension == "some updated f_extension"
      assert stored_media.f_type == "some updated f_type"
      assert stored_media.name == "some updated name"
      assert stored_media.s3_url == "some updated s3_url"
      assert stored_media.size == 43
    end

    test "update_stored_media/2 with invalid data returns error changeset" do
      stored_media = stored_media_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Settings.update_stored_media(stored_media, @invalid_attrs)

      assert stored_media == Settings.get_stored_media!(stored_media.id)
    end

    test "delete_stored_media/1 deletes the stored_media" do
      stored_media = stored_media_fixture()
      assert {:ok, %StoredMedia{}} = Settings.delete_stored_media(stored_media)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_stored_media!(stored_media.id) end
    end

    test "change_stored_media/1 returns a stored_media changeset" do
      stored_media = stored_media_fixture()
      assert %Ecto.Changeset{} = Settings.change_stored_media(stored_media)
    end
  end

  describe "shops" do
    alias United.Settings.Shop

    @valid_attrs %{address: "some address", description: "some description", email: "some email", img_url: "some img_url", name: "some name", phone: "some phone"}
    @update_attrs %{address: "some updated address", description: "some updated description", email: "some updated email", img_url: "some updated img_url", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{address: nil, description: nil, email: nil, img_url: nil, name: nil, phone: nil}

    def shop_fixture(attrs \\ %{}) do
      {:ok, shop} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_shop()

      shop
    end

    test "list_shops/0 returns all shops" do
      shop = shop_fixture()
      assert Settings.list_shops() == [shop]
    end

    test "get_shop!/1 returns the shop with given id" do
      shop = shop_fixture()
      assert Settings.get_shop!(shop.id) == shop
    end

    test "create_shop/1 with valid data creates a shop" do
      assert {:ok, %Shop{} = shop} = Settings.create_shop(@valid_attrs)
      assert shop.address == "some address"
      assert shop.description == "some description"
      assert shop.email == "some email"
      assert shop.img_url == "some img_url"
      assert shop.name == "some name"
      assert shop.phone == "some phone"
    end

    test "create_shop/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_shop(@invalid_attrs)
    end

    test "update_shop/2 with valid data updates the shop" do
      shop = shop_fixture()
      assert {:ok, %Shop{} = shop} = Settings.update_shop(shop, @update_attrs)
      assert shop.address == "some updated address"
      assert shop.description == "some updated description"
      assert shop.email == "some updated email"
      assert shop.img_url == "some updated img_url"
      assert shop.name == "some updated name"
      assert shop.phone == "some updated phone"
    end

    test "update_shop/2 with invalid data returns error changeset" do
      shop = shop_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_shop(shop, @invalid_attrs)
      assert shop == Settings.get_shop!(shop.id)
    end

    test "delete_shop/1 deletes the shop" do
      shop = shop_fixture()
      assert {:ok, %Shop{}} = Settings.delete_shop(shop)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_shop!(shop.id) end
    end

    test "change_shop/1 returns a shop changeset" do
      shop = shop_fixture()
      assert %Ecto.Changeset{} = Settings.change_shop(shop)
    end
  end

  describe "shop_products" do
    alias United.Settings.ShopProduct

    @valid_attrs %{cost_price: 120.5, long_desc: "some long_desc", name: "some name", promo_price: 120.5, retail_price: 120.5, shop_id: 42, short_desc: "some short_desc"}
    @update_attrs %{cost_price: 456.7, long_desc: "some updated long_desc", name: "some updated name", promo_price: 456.7, retail_price: 456.7, shop_id: 43, short_desc: "some updated short_desc"}
    @invalid_attrs %{cost_price: nil, long_desc: nil, name: nil, promo_price: nil, retail_price: nil, shop_id: nil, short_desc: nil}

    def shop_product_fixture(attrs \\ %{}) do
      {:ok, shop_product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_shop_product()

      shop_product
    end

    test "list_shop_products/0 returns all shop_products" do
      shop_product = shop_product_fixture()
      assert Settings.list_shop_products() == [shop_product]
    end

    test "get_shop_product!/1 returns the shop_product with given id" do
      shop_product = shop_product_fixture()
      assert Settings.get_shop_product!(shop_product.id) == shop_product
    end

    test "create_shop_product/1 with valid data creates a shop_product" do
      assert {:ok, %ShopProduct{} = shop_product} = Settings.create_shop_product(@valid_attrs)
      assert shop_product.cost_price == 120.5
      assert shop_product.long_desc == "some long_desc"
      assert shop_product.name == "some name"
      assert shop_product.promo_price == 120.5
      assert shop_product.retail_price == 120.5
      assert shop_product.shop_id == 42
      assert shop_product.short_desc == "some short_desc"
    end

    test "create_shop_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_shop_product(@invalid_attrs)
    end

    test "update_shop_product/2 with valid data updates the shop_product" do
      shop_product = shop_product_fixture()
      assert {:ok, %ShopProduct{} = shop_product} = Settings.update_shop_product(shop_product, @update_attrs)
      assert shop_product.cost_price == 456.7
      assert shop_product.long_desc == "some updated long_desc"
      assert shop_product.name == "some updated name"
      assert shop_product.promo_price == 456.7
      assert shop_product.retail_price == 456.7
      assert shop_product.shop_id == 43
      assert shop_product.short_desc == "some updated short_desc"
    end

    test "update_shop_product/2 with invalid data returns error changeset" do
      shop_product = shop_product_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_shop_product(shop_product, @invalid_attrs)
      assert shop_product == Settings.get_shop_product!(shop_product.id)
    end

    test "delete_shop_product/1 deletes the shop_product" do
      shop_product = shop_product_fixture()
      assert {:ok, %ShopProduct{}} = Settings.delete_shop_product(shop_product)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_shop_product!(shop_product.id) end
    end

    test "change_shop_product/1 returns a shop_product changeset" do
      shop_product = shop_product_fixture()
      assert %Ecto.Changeset{} = Settings.change_shop_product(shop_product)
    end
  end

  describe "tags" do
    alias United.Settings.Tag

    @valid_attrs %{desc: "some desc", name: "some name"}
    @update_attrs %{desc: "some updated desc", name: "some updated name"}
    @invalid_attrs %{desc: nil, name: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Settings.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Settings.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Settings.create_tag(@valid_attrs)
      assert tag.desc == "some desc"
      assert tag.name == "some name"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{} = tag} = Settings.update_tag(tag, @update_attrs)
      assert tag.desc == "some updated desc"
      assert tag.name == "some updated name"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_tag(tag, @invalid_attrs)
      assert tag == Settings.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Settings.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Settings.change_tag(tag)
    end
  end

  describe "shop_product_tags" do
    alias United.Settings.ShopProductTag

    @valid_attrs %{shop_product_id: 42, tag_id: 42}
    @update_attrs %{shop_product_id: 43, tag_id: 43}
    @invalid_attrs %{shop_product_id: nil, tag_id: nil}

    def shop_product_tag_fixture(attrs \\ %{}) do
      {:ok, shop_product_tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_shop_product_tag()

      shop_product_tag
    end

    test "list_shop_product_tags/0 returns all shop_product_tags" do
      shop_product_tag = shop_product_tag_fixture()
      assert Settings.list_shop_product_tags() == [shop_product_tag]
    end

    test "get_shop_product_tag!/1 returns the shop_product_tag with given id" do
      shop_product_tag = shop_product_tag_fixture()
      assert Settings.get_shop_product_tag!(shop_product_tag.id) == shop_product_tag
    end

    test "create_shop_product_tag/1 with valid data creates a shop_product_tag" do
      assert {:ok, %ShopProductTag{} = shop_product_tag} = Settings.create_shop_product_tag(@valid_attrs)
      assert shop_product_tag.shop_product_id == 42
      assert shop_product_tag.tag_id == 42
    end

    test "create_shop_product_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_shop_product_tag(@invalid_attrs)
    end

    test "update_shop_product_tag/2 with valid data updates the shop_product_tag" do
      shop_product_tag = shop_product_tag_fixture()
      assert {:ok, %ShopProductTag{} = shop_product_tag} = Settings.update_shop_product_tag(shop_product_tag, @update_attrs)
      assert shop_product_tag.shop_product_id == 43
      assert shop_product_tag.tag_id == 43
    end

    test "update_shop_product_tag/2 with invalid data returns error changeset" do
      shop_product_tag = shop_product_tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_shop_product_tag(shop_product_tag, @invalid_attrs)
      assert shop_product_tag == Settings.get_shop_product_tag!(shop_product_tag.id)
    end

    test "delete_shop_product_tag/1 deletes the shop_product_tag" do
      shop_product_tag = shop_product_tag_fixture()
      assert {:ok, %ShopProductTag{}} = Settings.delete_shop_product_tag(shop_product_tag)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_shop_product_tag!(shop_product_tag.id) end
    end

    test "change_shop_product_tag/1 returns a shop_product_tag changeset" do
      shop_product_tag = shop_product_tag_fixture()
      assert %Ecto.Changeset{} = Settings.change_shop_product_tag(shop_product_tag)
    end
  end

  describe "facebook_pages" do
    alias United.Settings.FacebookPage

    @valid_attrs %{name: "some name", page_access_token: "some page_access_token", page_id: "some page_id", shop_id: 42, user_id: 42}
    @update_attrs %{name: "some updated name", page_access_token: "some updated page_access_token", page_id: "some updated page_id", shop_id: 43, user_id: 43}
    @invalid_attrs %{name: nil, page_access_token: nil, page_id: nil, shop_id: nil, user_id: nil}

    def facebook_page_fixture(attrs \\ %{}) do
      {:ok, facebook_page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_facebook_page()

      facebook_page
    end

    test "list_facebook_pages/0 returns all facebook_pages" do
      facebook_page = facebook_page_fixture()
      assert Settings.list_facebook_pages() == [facebook_page]
    end

    test "get_facebook_page!/1 returns the facebook_page with given id" do
      facebook_page = facebook_page_fixture()
      assert Settings.get_facebook_page!(facebook_page.id) == facebook_page
    end

    test "create_facebook_page/1 with valid data creates a facebook_page" do
      assert {:ok, %FacebookPage{} = facebook_page} = Settings.create_facebook_page(@valid_attrs)
      assert facebook_page.name == "some name"
      assert facebook_page.page_access_token == "some page_access_token"
      assert facebook_page.page_id == "some page_id"
      assert facebook_page.shop_id == 42
      assert facebook_page.user_id == 42
    end

    test "create_facebook_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_facebook_page(@invalid_attrs)
    end

    test "update_facebook_page/2 with valid data updates the facebook_page" do
      facebook_page = facebook_page_fixture()
      assert {:ok, %FacebookPage{} = facebook_page} = Settings.update_facebook_page(facebook_page, @update_attrs)
      assert facebook_page.name == "some updated name"
      assert facebook_page.page_access_token == "some updated page_access_token"
      assert facebook_page.page_id == "some updated page_id"
      assert facebook_page.shop_id == 43
      assert facebook_page.user_id == 43
    end

    test "update_facebook_page/2 with invalid data returns error changeset" do
      facebook_page = facebook_page_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_facebook_page(facebook_page, @invalid_attrs)
      assert facebook_page == Settings.get_facebook_page!(facebook_page.id)
    end

    test "delete_facebook_page/1 deletes the facebook_page" do
      facebook_page = facebook_page_fixture()
      assert {:ok, %FacebookPage{}} = Settings.delete_facebook_page(facebook_page)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_facebook_page!(facebook_page.id) end
    end

    test "change_facebook_page/1 returns a facebook_page changeset" do
      facebook_page = facebook_page_fixture()
      assert %Ecto.Changeset{} = Settings.change_facebook_page(facebook_page)
    end
  end

  describe "live_videos" do
    alias United.Settings.LiveVideo

    @valid_attrs %{created_at: ~N[2010-04-17 14:00:00], description: "some description", embed_html: "some embed_html", facebook_page_id: 42, live_id: "some live_id", picture: "some picture", title: "some title"}
    @update_attrs %{created_at: ~N[2011-05-18 15:01:01], description: "some updated description", embed_html: "some updated embed_html", facebook_page_id: 43, live_id: "some updated live_id", picture: "some updated picture", title: "some updated title"}
    @invalid_attrs %{created_at: nil, description: nil, embed_html: nil, facebook_page_id: nil, live_id: nil, picture: nil, title: nil}

    def live_video_fixture(attrs \\ %{}) do
      {:ok, live_video} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_live_video()

      live_video
    end

    test "list_live_videos/0 returns all live_videos" do
      live_video = live_video_fixture()
      assert Settings.list_live_videos() == [live_video]
    end

    test "get_live_video!/1 returns the live_video with given id" do
      live_video = live_video_fixture()
      assert Settings.get_live_video!(live_video.id) == live_video
    end

    test "create_live_video/1 with valid data creates a live_video" do
      assert {:ok, %LiveVideo{} = live_video} = Settings.create_live_video(@valid_attrs)
      assert live_video.created_at == ~N[2010-04-17 14:00:00]
      assert live_video.description == "some description"
      assert live_video.embed_html == "some embed_html"
      assert live_video.facebook_page_id == 42
      assert live_video.live_id == "some live_id"
      assert live_video.picture == "some picture"
      assert live_video.title == "some title"
    end

    test "create_live_video/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_live_video(@invalid_attrs)
    end

    test "update_live_video/2 with valid data updates the live_video" do
      live_video = live_video_fixture()
      assert {:ok, %LiveVideo{} = live_video} = Settings.update_live_video(live_video, @update_attrs)
      assert live_video.created_at == ~N[2011-05-18 15:01:01]
      assert live_video.description == "some updated description"
      assert live_video.embed_html == "some updated embed_html"
      assert live_video.facebook_page_id == 43
      assert live_video.live_id == "some updated live_id"
      assert live_video.picture == "some updated picture"
      assert live_video.title == "some updated title"
    end

    test "update_live_video/2 with invalid data returns error changeset" do
      live_video = live_video_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_live_video(live_video, @invalid_attrs)
      assert live_video == Settings.get_live_video!(live_video.id)
    end

    test "delete_live_video/1 deletes the live_video" do
      live_video = live_video_fixture()
      assert {:ok, %LiveVideo{}} = Settings.delete_live_video(live_video)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_live_video!(live_video.id) end
    end

    test "change_live_video/1 returns a live_video changeset" do
      live_video = live_video_fixture()
      assert %Ecto.Changeset{} = Settings.change_live_video(live_video)
    end
  end

  describe "video_comments" do
    alias United.Settings.VideoComment

    @valid_attrs %{created_at: ~N[2010-04-17 14:00:00], message: "some message", ms_id: "some ms_id", page_visitor_id: 42}
    @update_attrs %{created_at: ~N[2011-05-18 15:01:01], message: "some updated message", ms_id: "some updated ms_id", page_visitor_id: 43}
    @invalid_attrs %{created_at: nil, message: nil, ms_id: nil, page_visitor_id: nil}

    def video_comment_fixture(attrs \\ %{}) do
      {:ok, video_comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_video_comment()

      video_comment
    end

    test "list_video_comments/0 returns all video_comments" do
      video_comment = video_comment_fixture()
      assert Settings.list_video_comments() == [video_comment]
    end

    test "get_video_comment!/1 returns the video_comment with given id" do
      video_comment = video_comment_fixture()
      assert Settings.get_video_comment!(video_comment.id) == video_comment
    end

    test "create_video_comment/1 with valid data creates a video_comment" do
      assert {:ok, %VideoComment{} = video_comment} = Settings.create_video_comment(@valid_attrs)
      assert video_comment.created_at == ~N[2010-04-17 14:00:00]
      assert video_comment.message == "some message"
      assert video_comment.ms_id == "some ms_id"
      assert video_comment.page_visitor_id == 42
    end

    test "create_video_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_video_comment(@invalid_attrs)
    end

    test "update_video_comment/2 with valid data updates the video_comment" do
      video_comment = video_comment_fixture()
      assert {:ok, %VideoComment{} = video_comment} = Settings.update_video_comment(video_comment, @update_attrs)
      assert video_comment.created_at == ~N[2011-05-18 15:01:01]
      assert video_comment.message == "some updated message"
      assert video_comment.ms_id == "some updated ms_id"
      assert video_comment.page_visitor_id == 43
    end

    test "update_video_comment/2 with invalid data returns error changeset" do
      video_comment = video_comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_video_comment(video_comment, @invalid_attrs)
      assert video_comment == Settings.get_video_comment!(video_comment.id)
    end

    test "delete_video_comment/1 deletes the video_comment" do
      video_comment = video_comment_fixture()
      assert {:ok, %VideoComment{}} = Settings.delete_video_comment(video_comment)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_video_comment!(video_comment.id) end
    end

    test "change_video_comment/1 returns a video_comment changeset" do
      video_comment = video_comment_fixture()
      assert %Ecto.Changeset{} = Settings.change_video_comment(video_comment)
    end
  end

  describe "page_visitors" do
    alias United.Settings.PageVisitor

    @valid_attrs %{email: "some email", facebook_page_id: 42, name: "some name", phone: "some phone", profile_pic: "some profile_pic", psid: "some psid"}
    @update_attrs %{email: "some updated email", facebook_page_id: 43, name: "some updated name", phone: "some updated phone", profile_pic: "some updated profile_pic", psid: "some updated psid"}
    @invalid_attrs %{email: nil, facebook_page_id: nil, name: nil, phone: nil, profile_pic: nil, psid: nil}

    def page_visitor_fixture(attrs \\ %{}) do
      {:ok, page_visitor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_page_visitor()

      page_visitor
    end

    test "list_page_visitors/0 returns all page_visitors" do
      page_visitor = page_visitor_fixture()
      assert Settings.list_page_visitors() == [page_visitor]
    end

    test "get_page_visitor!/1 returns the page_visitor with given id" do
      page_visitor = page_visitor_fixture()
      assert Settings.get_page_visitor!(page_visitor.id) == page_visitor
    end

    test "create_page_visitor/1 with valid data creates a page_visitor" do
      assert {:ok, %PageVisitor{} = page_visitor} = Settings.create_page_visitor(@valid_attrs)
      assert page_visitor.email == "some email"
      assert page_visitor.facebook_page_id == 42
      assert page_visitor.name == "some name"
      assert page_visitor.phone == "some phone"
      assert page_visitor.profile_pic == "some profile_pic"
      assert page_visitor.psid == "some psid"
    end

    test "create_page_visitor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_page_visitor(@invalid_attrs)
    end

    test "update_page_visitor/2 with valid data updates the page_visitor" do
      page_visitor = page_visitor_fixture()
      assert {:ok, %PageVisitor{} = page_visitor} = Settings.update_page_visitor(page_visitor, @update_attrs)
      assert page_visitor.email == "some updated email"
      assert page_visitor.facebook_page_id == 43
      assert page_visitor.name == "some updated name"
      assert page_visitor.phone == "some updated phone"
      assert page_visitor.profile_pic == "some updated profile_pic"
      assert page_visitor.psid == "some updated psid"
    end

    test "update_page_visitor/2 with invalid data returns error changeset" do
      page_visitor = page_visitor_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_page_visitor(page_visitor, @invalid_attrs)
      assert page_visitor == Settings.get_page_visitor!(page_visitor.id)
    end

    test "delete_page_visitor/1 deletes the page_visitor" do
      page_visitor = page_visitor_fixture()
      assert {:ok, %PageVisitor{}} = Settings.delete_page_visitor(page_visitor)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_page_visitor!(page_visitor.id) end
    end

    test "change_page_visitor/1 returns a page_visitor changeset" do
      page_visitor = page_visitor_fixture()
      assert %Ecto.Changeset{} = Settings.change_page_visitor(page_visitor)
    end
  end

  describe "customer_orders" do
    alias United.Settings.CustomerOrder

    @valid_attrs %{date: ~D[2010-04-17], delivery_address: "some delivery_address", delivery_fee: 120.5, delivery_phone: "some delivery_phone", facebook_page_id: 42, grand_total: 120.5, page_visitor_id: 42, payment_gateway_link: "some payment_gateway_link", receipt_upload_link: "some receipt_upload_link", remarks: "some remarks", status: "some status", sub_total: 120.5, user_id: 42}
    @update_attrs %{date: ~D[2011-05-18], delivery_address: "some updated delivery_address", delivery_fee: 456.7, delivery_phone: "some updated delivery_phone", facebook_page_id: 43, grand_total: 456.7, page_visitor_id: 43, payment_gateway_link: "some updated payment_gateway_link", receipt_upload_link: "some updated receipt_upload_link", remarks: "some updated remarks", status: "some updated status", sub_total: 456.7, user_id: 43}
    @invalid_attrs %{date: nil, delivery_address: nil, delivery_fee: nil, delivery_phone: nil, facebook_page_id: nil, grand_total: nil, page_visitor_id: nil, payment_gateway_link: nil, receipt_upload_link: nil, remarks: nil, status: nil, sub_total: nil, user_id: nil}

    def customer_order_fixture(attrs \\ %{}) do
      {:ok, customer_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_customer_order()

      customer_order
    end

    test "list_customer_orders/0 returns all customer_orders" do
      customer_order = customer_order_fixture()
      assert Settings.list_customer_orders() == [customer_order]
    end

    test "get_customer_order!/1 returns the customer_order with given id" do
      customer_order = customer_order_fixture()
      assert Settings.get_customer_order!(customer_order.id) == customer_order
    end

    test "create_customer_order/1 with valid data creates a customer_order" do
      assert {:ok, %CustomerOrder{} = customer_order} = Settings.create_customer_order(@valid_attrs)
      assert customer_order.date == ~D[2010-04-17]
      assert customer_order.delivery_address == "some delivery_address"
      assert customer_order.delivery_fee == 120.5
      assert customer_order.delivery_phone == "some delivery_phone"
      assert customer_order.facebook_page_id == 42
      assert customer_order.grand_total == 120.5
      assert customer_order.page_visitor_id == 42
      assert customer_order.payment_gateway_link == "some payment_gateway_link"
      assert customer_order.receipt_upload_link == "some receipt_upload_link"
      assert customer_order.remarks == "some remarks"
      assert customer_order.status == "some status"
      assert customer_order.sub_total == 120.5
      assert customer_order.user_id == 42
    end

    test "create_customer_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_customer_order(@invalid_attrs)
    end

    test "update_customer_order/2 with valid data updates the customer_order" do
      customer_order = customer_order_fixture()
      assert {:ok, %CustomerOrder{} = customer_order} = Settings.update_customer_order(customer_order, @update_attrs)
      assert customer_order.date == ~D[2011-05-18]
      assert customer_order.delivery_address == "some updated delivery_address"
      assert customer_order.delivery_fee == 456.7
      assert customer_order.delivery_phone == "some updated delivery_phone"
      assert customer_order.facebook_page_id == 43
      assert customer_order.grand_total == 456.7
      assert customer_order.page_visitor_id == 43
      assert customer_order.payment_gateway_link == "some updated payment_gateway_link"
      assert customer_order.receipt_upload_link == "some updated receipt_upload_link"
      assert customer_order.remarks == "some updated remarks"
      assert customer_order.status == "some updated status"
      assert customer_order.sub_total == 456.7
      assert customer_order.user_id == 43
    end

    test "update_customer_order/2 with invalid data returns error changeset" do
      customer_order = customer_order_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_customer_order(customer_order, @invalid_attrs)
      assert customer_order == Settings.get_customer_order!(customer_order.id)
    end

    test "delete_customer_order/1 deletes the customer_order" do
      customer_order = customer_order_fixture()
      assert {:ok, %CustomerOrder{}} = Settings.delete_customer_order(customer_order)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_customer_order!(customer_order.id) end
    end

    test "change_customer_order/1 returns a customer_order changeset" do
      customer_order = customer_order_fixture()
      assert %Ecto.Changeset{} = Settings.change_customer_order(customer_order)
    end
  end

  describe "customer_order_lines" do
    alias United.Settings.CustomerOrderLine

    @valid_attrs %{cost_price: 120.5, customer_order_id: 42, item_name: "some item_name", live_comment_id: 42, qty: 42, remarks: "some remarks", sub_total: 120.5}
    @update_attrs %{cost_price: 456.7, customer_order_id: 43, item_name: "some updated item_name", live_comment_id: 43, qty: 43, remarks: "some updated remarks", sub_total: 456.7}
    @invalid_attrs %{cost_price: nil, customer_order_id: nil, item_name: nil, live_comment_id: nil, qty: nil, remarks: nil, sub_total: nil}

    def customer_order_line_fixture(attrs \\ %{}) do
      {:ok, customer_order_line} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_customer_order_line()

      customer_order_line
    end

    test "list_customer_order_lines/0 returns all customer_order_lines" do
      customer_order_line = customer_order_line_fixture()
      assert Settings.list_customer_order_lines() == [customer_order_line]
    end

    test "get_customer_order_line!/1 returns the customer_order_line with given id" do
      customer_order_line = customer_order_line_fixture()
      assert Settings.get_customer_order_line!(customer_order_line.id) == customer_order_line
    end

    test "create_customer_order_line/1 with valid data creates a customer_order_line" do
      assert {:ok, %CustomerOrderLine{} = customer_order_line} = Settings.create_customer_order_line(@valid_attrs)
      assert customer_order_line.cost_price == 120.5
      assert customer_order_line.customer_order_id == 42
      assert customer_order_line.item_name == "some item_name"
      assert customer_order_line.live_comment_id == 42
      assert customer_order_line.qty == 42
      assert customer_order_line.remarks == "some remarks"
      assert customer_order_line.sub_total == 120.5
    end

    test "create_customer_order_line/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_customer_order_line(@invalid_attrs)
    end

    test "update_customer_order_line/2 with valid data updates the customer_order_line" do
      customer_order_line = customer_order_line_fixture()
      assert {:ok, %CustomerOrderLine{} = customer_order_line} = Settings.update_customer_order_line(customer_order_line, @update_attrs)
      assert customer_order_line.cost_price == 456.7
      assert customer_order_line.customer_order_id == 43
      assert customer_order_line.item_name == "some updated item_name"
      assert customer_order_line.live_comment_id == 43
      assert customer_order_line.qty == 43
      assert customer_order_line.remarks == "some updated remarks"
      assert customer_order_line.sub_total == 456.7
    end

    test "update_customer_order_line/2 with invalid data returns error changeset" do
      customer_order_line = customer_order_line_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_customer_order_line(customer_order_line, @invalid_attrs)
      assert customer_order_line == Settings.get_customer_order_line!(customer_order_line.id)
    end

    test "delete_customer_order_line/1 deletes the customer_order_line" do
      customer_order_line = customer_order_line_fixture()
      assert {:ok, %CustomerOrderLine{}} = Settings.delete_customer_order_line(customer_order_line)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_customer_order_line!(customer_order_line.id) end
    end

    test "change_customer_order_line/1 returns a customer_order_line changeset" do
      customer_order_line = customer_order_line_fixture()
      assert %Ecto.Changeset{} = Settings.change_customer_order_line(customer_order_line)
    end
  end
end
