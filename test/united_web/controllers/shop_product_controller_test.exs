defmodule UnitedWeb.ShopProductControllerTest do
  use UnitedWeb.ConnCase

  alias United.Settings

  @create_attrs %{cost_price: 120.5, long_desc: "some long_desc", name: "some name", promo_price: 120.5, retail_price: 120.5, shop_id: 42, short_desc: "some short_desc"}
  @update_attrs %{cost_price: 456.7, long_desc: "some updated long_desc", name: "some updated name", promo_price: 456.7, retail_price: 456.7, shop_id: 43, short_desc: "some updated short_desc"}
  @invalid_attrs %{cost_price: nil, long_desc: nil, name: nil, promo_price: nil, retail_price: nil, shop_id: nil, short_desc: nil}

  def fixture(:shop_product) do
    {:ok, shop_product} = Settings.create_shop_product(@create_attrs)
    shop_product
  end

  describe "index" do
    test "lists all shop_products", %{conn: conn} do
      conn = get(conn, Routes.shop_product_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Shop products"
    end
  end

  describe "new shop_product" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.shop_product_path(conn, :new))
      assert html_response(conn, 200) =~ "New Shop product"
    end
  end

  describe "create shop_product" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.shop_product_path(conn, :create), shop_product: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.shop_product_path(conn, :show, id)

      conn = get(conn, Routes.shop_product_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Shop product"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.shop_product_path(conn, :create), shop_product: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Shop product"
    end
  end

  describe "edit shop_product" do
    setup [:create_shop_product]

    test "renders form for editing chosen shop_product", %{conn: conn, shop_product: shop_product} do
      conn = get(conn, Routes.shop_product_path(conn, :edit, shop_product))
      assert html_response(conn, 200) =~ "Edit Shop product"
    end
  end

  describe "update shop_product" do
    setup [:create_shop_product]

    test "redirects when data is valid", %{conn: conn, shop_product: shop_product} do
      conn = put(conn, Routes.shop_product_path(conn, :update, shop_product), shop_product: @update_attrs)
      assert redirected_to(conn) == Routes.shop_product_path(conn, :show, shop_product)

      conn = get(conn, Routes.shop_product_path(conn, :show, shop_product))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, shop_product: shop_product} do
      conn = put(conn, Routes.shop_product_path(conn, :update, shop_product), shop_product: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Shop product"
    end
  end

  describe "delete shop_product" do
    setup [:create_shop_product]

    test "deletes chosen shop_product", %{conn: conn, shop_product: shop_product} do
      conn = delete(conn, Routes.shop_product_path(conn, :delete, shop_product))
      assert redirected_to(conn) == Routes.shop_product_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.shop_product_path(conn, :show, shop_product))
      end
    end
  end

  defp create_shop_product(_) do
    shop_product = fixture(:shop_product)
    %{shop_product: shop_product}
  end
end
