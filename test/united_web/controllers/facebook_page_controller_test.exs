defmodule UnitedWeb.FacebookPageControllerTest do
  use UnitedWeb.ConnCase

  alias United.Settings

  @create_attrs %{name: "some name", page_access_token: "some page_access_token", page_id: "some page_id", shop_id: 42, user_id: 42}
  @update_attrs %{name: "some updated name", page_access_token: "some updated page_access_token", page_id: "some updated page_id", shop_id: 43, user_id: 43}
  @invalid_attrs %{name: nil, page_access_token: nil, page_id: nil, shop_id: nil, user_id: nil}

  def fixture(:facebook_page) do
    {:ok, facebook_page} = Settings.create_facebook_page(@create_attrs)
    facebook_page
  end

  describe "index" do
    test "lists all facebook_pages", %{conn: conn} do
      conn = get(conn, Routes.facebook_page_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Facebook pages"
    end
  end

  describe "new facebook_page" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.facebook_page_path(conn, :new))
      assert html_response(conn, 200) =~ "New Facebook page"
    end
  end

  describe "create facebook_page" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.facebook_page_path(conn, :create), facebook_page: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.facebook_page_path(conn, :show, id)

      conn = get(conn, Routes.facebook_page_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Facebook page"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_page_path(conn, :create), facebook_page: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Facebook page"
    end
  end

  describe "edit facebook_page" do
    setup [:create_facebook_page]

    test "renders form for editing chosen facebook_page", %{conn: conn, facebook_page: facebook_page} do
      conn = get(conn, Routes.facebook_page_path(conn, :edit, facebook_page))
      assert html_response(conn, 200) =~ "Edit Facebook page"
    end
  end

  describe "update facebook_page" do
    setup [:create_facebook_page]

    test "redirects when data is valid", %{conn: conn, facebook_page: facebook_page} do
      conn = put(conn, Routes.facebook_page_path(conn, :update, facebook_page), facebook_page: @update_attrs)
      assert redirected_to(conn) == Routes.facebook_page_path(conn, :show, facebook_page)

      conn = get(conn, Routes.facebook_page_path(conn, :show, facebook_page))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, facebook_page: facebook_page} do
      conn = put(conn, Routes.facebook_page_path(conn, :update, facebook_page), facebook_page: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Facebook page"
    end
  end

  describe "delete facebook_page" do
    setup [:create_facebook_page]

    test "deletes chosen facebook_page", %{conn: conn, facebook_page: facebook_page} do
      conn = delete(conn, Routes.facebook_page_path(conn, :delete, facebook_page))
      assert redirected_to(conn) == Routes.facebook_page_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.facebook_page_path(conn, :show, facebook_page))
      end
    end
  end

  defp create_facebook_page(_) do
    facebook_page = fixture(:facebook_page)
    %{facebook_page: facebook_page}
  end
end
