defmodule UnitedWeb.ShopProductTagControllerTest do
  use UnitedWeb.ConnCase

  alias United.Settings

  @create_attrs %{shop_product_id: 42, tag_id: 42}
  @update_attrs %{shop_product_id: 43, tag_id: 43}
  @invalid_attrs %{shop_product_id: nil, tag_id: nil}

  def fixture(:shop_product_tag) do
    {:ok, shop_product_tag} = Settings.create_shop_product_tag(@create_attrs)
    shop_product_tag
  end

  describe "index" do
    test "lists all shop_product_tags", %{conn: conn} do
      conn = get(conn, Routes.shop_product_tag_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Shop product tags"
    end
  end

  describe "new shop_product_tag" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.shop_product_tag_path(conn, :new))
      assert html_response(conn, 200) =~ "New Shop product tag"
    end
  end

  describe "create shop_product_tag" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.shop_product_tag_path(conn, :create), shop_product_tag: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.shop_product_tag_path(conn, :show, id)

      conn = get(conn, Routes.shop_product_tag_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Shop product tag"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.shop_product_tag_path(conn, :create), shop_product_tag: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Shop product tag"
    end
  end

  describe "edit shop_product_tag" do
    setup [:create_shop_product_tag]

    test "renders form for editing chosen shop_product_tag", %{conn: conn, shop_product_tag: shop_product_tag} do
      conn = get(conn, Routes.shop_product_tag_path(conn, :edit, shop_product_tag))
      assert html_response(conn, 200) =~ "Edit Shop product tag"
    end
  end

  describe "update shop_product_tag" do
    setup [:create_shop_product_tag]

    test "redirects when data is valid", %{conn: conn, shop_product_tag: shop_product_tag} do
      conn = put(conn, Routes.shop_product_tag_path(conn, :update, shop_product_tag), shop_product_tag: @update_attrs)
      assert redirected_to(conn) == Routes.shop_product_tag_path(conn, :show, shop_product_tag)

      conn = get(conn, Routes.shop_product_tag_path(conn, :show, shop_product_tag))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, shop_product_tag: shop_product_tag} do
      conn = put(conn, Routes.shop_product_tag_path(conn, :update, shop_product_tag), shop_product_tag: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Shop product tag"
    end
  end

  describe "delete shop_product_tag" do
    setup [:create_shop_product_tag]

    test "deletes chosen shop_product_tag", %{conn: conn, shop_product_tag: shop_product_tag} do
      conn = delete(conn, Routes.shop_product_tag_path(conn, :delete, shop_product_tag))
      assert redirected_to(conn) == Routes.shop_product_tag_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.shop_product_tag_path(conn, :show, shop_product_tag))
      end
    end
  end

  defp create_shop_product_tag(_) do
    shop_product_tag = fixture(:shop_product_tag)
    %{shop_product_tag: shop_product_tag}
  end
end
