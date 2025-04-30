defmodule UnitedWeb.CustomerOrderControllerTest do
  use UnitedWeb.ConnCase

  alias United.Settings

  @create_attrs %{date: ~D[2010-04-17], delivery_address: "some delivery_address", delivery_fee: 120.5, delivery_phone: "some delivery_phone", facebook_page_id: 42, grand_total: 120.5, page_visitor_id: 42, payment_gateway_link: "some payment_gateway_link", receipt_upload_link: "some receipt_upload_link", remarks: "some remarks", status: "some status", sub_total: 120.5, user_id: 42}
  @update_attrs %{date: ~D[2011-05-18], delivery_address: "some updated delivery_address", delivery_fee: 456.7, delivery_phone: "some updated delivery_phone", facebook_page_id: 43, grand_total: 456.7, page_visitor_id: 43, payment_gateway_link: "some updated payment_gateway_link", receipt_upload_link: "some updated receipt_upload_link", remarks: "some updated remarks", status: "some updated status", sub_total: 456.7, user_id: 43}
  @invalid_attrs %{date: nil, delivery_address: nil, delivery_fee: nil, delivery_phone: nil, facebook_page_id: nil, grand_total: nil, page_visitor_id: nil, payment_gateway_link: nil, receipt_upload_link: nil, remarks: nil, status: nil, sub_total: nil, user_id: nil}

  def fixture(:customer_order) do
    {:ok, customer_order} = Settings.create_customer_order(@create_attrs)
    customer_order
  end

  describe "index" do
    test "lists all customer_orders", %{conn: conn} do
      conn = get(conn, Routes.customer_order_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Customer orders"
    end
  end

  describe "new customer_order" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.customer_order_path(conn, :new))
      assert html_response(conn, 200) =~ "New Customer order"
    end
  end

  describe "create customer_order" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.customer_order_path(conn, :create), customer_order: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.customer_order_path(conn, :show, id)

      conn = get(conn, Routes.customer_order_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Customer order"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.customer_order_path(conn, :create), customer_order: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Customer order"
    end
  end

  describe "edit customer_order" do
    setup [:create_customer_order]

    test "renders form for editing chosen customer_order", %{conn: conn, customer_order: customer_order} do
      conn = get(conn, Routes.customer_order_path(conn, :edit, customer_order))
      assert html_response(conn, 200) =~ "Edit Customer order"
    end
  end

  describe "update customer_order" do
    setup [:create_customer_order]

    test "redirects when data is valid", %{conn: conn, customer_order: customer_order} do
      conn = put(conn, Routes.customer_order_path(conn, :update, customer_order), customer_order: @update_attrs)
      assert redirected_to(conn) == Routes.customer_order_path(conn, :show, customer_order)

      conn = get(conn, Routes.customer_order_path(conn, :show, customer_order))
      assert html_response(conn, 200) =~ "some updated delivery_address"
    end

    test "renders errors when data is invalid", %{conn: conn, customer_order: customer_order} do
      conn = put(conn, Routes.customer_order_path(conn, :update, customer_order), customer_order: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Customer order"
    end
  end

  describe "delete customer_order" do
    setup [:create_customer_order]

    test "deletes chosen customer_order", %{conn: conn, customer_order: customer_order} do
      conn = delete(conn, Routes.customer_order_path(conn, :delete, customer_order))
      assert redirected_to(conn) == Routes.customer_order_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.customer_order_path(conn, :show, customer_order))
      end
    end
  end

  defp create_customer_order(_) do
    customer_order = fixture(:customer_order)
    %{customer_order: customer_order}
  end
end
