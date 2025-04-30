defmodule UnitedWeb.PageVisitorControllerTest do
  use UnitedWeb.ConnCase

  alias United.Settings

  @create_attrs %{email: "some email", facebook_page_id: 42, name: "some name", phone: "some phone", profile_pic: "some profile_pic", psid: "some psid"}
  @update_attrs %{email: "some updated email", facebook_page_id: 43, name: "some updated name", phone: "some updated phone", profile_pic: "some updated profile_pic", psid: "some updated psid"}
  @invalid_attrs %{email: nil, facebook_page_id: nil, name: nil, phone: nil, profile_pic: nil, psid: nil}

  def fixture(:page_visitor) do
    {:ok, page_visitor} = Settings.create_page_visitor(@create_attrs)
    page_visitor
  end

  describe "index" do
    test "lists all page_visitors", %{conn: conn} do
      conn = get(conn, Routes.page_visitor_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Page visitors"
    end
  end

  describe "new page_visitor" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.page_visitor_path(conn, :new))
      assert html_response(conn, 200) =~ "New Page visitor"
    end
  end

  describe "create page_visitor" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.page_visitor_path(conn, :create), page_visitor: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.page_visitor_path(conn, :show, id)

      conn = get(conn, Routes.page_visitor_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Page visitor"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.page_visitor_path(conn, :create), page_visitor: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Page visitor"
    end
  end

  describe "edit page_visitor" do
    setup [:create_page_visitor]

    test "renders form for editing chosen page_visitor", %{conn: conn, page_visitor: page_visitor} do
      conn = get(conn, Routes.page_visitor_path(conn, :edit, page_visitor))
      assert html_response(conn, 200) =~ "Edit Page visitor"
    end
  end

  describe "update page_visitor" do
    setup [:create_page_visitor]

    test "redirects when data is valid", %{conn: conn, page_visitor: page_visitor} do
      conn = put(conn, Routes.page_visitor_path(conn, :update, page_visitor), page_visitor: @update_attrs)
      assert redirected_to(conn) == Routes.page_visitor_path(conn, :show, page_visitor)

      conn = get(conn, Routes.page_visitor_path(conn, :show, page_visitor))
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, page_visitor: page_visitor} do
      conn = put(conn, Routes.page_visitor_path(conn, :update, page_visitor), page_visitor: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Page visitor"
    end
  end

  describe "delete page_visitor" do
    setup [:create_page_visitor]

    test "deletes chosen page_visitor", %{conn: conn, page_visitor: page_visitor} do
      conn = delete(conn, Routes.page_visitor_path(conn, :delete, page_visitor))
      assert redirected_to(conn) == Routes.page_visitor_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.page_visitor_path(conn, :show, page_visitor))
      end
    end
  end

  defp create_page_visitor(_) do
    page_visitor = fixture(:page_visitor)
    %{page_visitor: page_visitor}
  end
end
