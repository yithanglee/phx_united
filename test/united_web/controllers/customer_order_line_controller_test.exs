defmodule UnitedWeb.CustomerOrderLineControllerTest do
  use UnitedWeb.ConnCase

  alias United.Settings

  @create_attrs %{cost_price: 120.5, customer_order_id: 42, item_name: "some item_name", live_comment_id: 42, qty: 42, remarks: "some remarks", sub_total: 120.5}
  @update_attrs %{cost_price: 456.7, customer_order_id: 43, item_name: "some updated item_name", live_comment_id: 43, qty: 43, remarks: "some updated remarks", sub_total: 456.7}
  @invalid_attrs %{cost_price: nil, customer_order_id: nil, item_name: nil, live_comment_id: nil, qty: nil, remarks: nil, sub_total: nil}

  def fixture(:customer_order_line) do
    {:ok, customer_order_line} = Settings.create_customer_order_line(@create_attrs)
    customer_order_line
  end

  describe "index" do
    test "lists all customer_order_lines", %{conn: conn} do
      conn = get(conn, Routes.customer_order_line_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Customer order lines"
    end
  end

  describe "new customer_order_line" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.customer_order_line_path(conn, :new))
      assert html_response(conn, 200) =~ "New Customer order line"
    end
  end

  describe "create customer_order_line" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.customer_order_line_path(conn, :create), customer_order_line: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.customer_order_line_path(conn, :show, id)

      conn = get(conn, Routes.customer_order_line_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Customer order line"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.customer_order_line_path(conn, :create), customer_order_line: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Customer order line"
    end
  end

  describe "edit customer_order_line" do
    setup [:create_customer_order_line]

    test "renders form for editing chosen customer_order_line", %{conn: conn, customer_order_line: customer_order_line} do
      conn = get(conn, Routes.customer_order_line_path(conn, :edit, customer_order_line))
      assert html_response(conn, 200) =~ "Edit Customer order line"
    end
  end

  describe "update customer_order_line" do
    setup [:create_customer_order_line]

    test "redirects when data is valid", %{conn: conn, customer_order_line: customer_order_line} do
      conn = put(conn, Routes.customer_order_line_path(conn, :update, customer_order_line), customer_order_line: @update_attrs)
      assert redirected_to(conn) == Routes.customer_order_line_path(conn, :show, customer_order_line)

      conn = get(conn, Routes.customer_order_line_path(conn, :show, customer_order_line))
      assert html_response(conn, 200) =~ "some updated item_name"
    end

    test "renders errors when data is invalid", %{conn: conn, customer_order_line: customer_order_line} do
      conn = put(conn, Routes.customer_order_line_path(conn, :update, customer_order_line), customer_order_line: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Customer order line"
    end
  end

  describe "delete customer_order_line" do
    setup [:create_customer_order_line]

    test "deletes chosen customer_order_line", %{conn: conn, customer_order_line: customer_order_line} do
      conn = delete(conn, Routes.customer_order_line_path(conn, :delete, customer_order_line))
      assert redirected_to(conn) == Routes.customer_order_line_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.customer_order_line_path(conn, :show, customer_order_line))
      end
    end
  end

  defp create_customer_order_line(_) do
    customer_order_line = fixture(:customer_order_line)
    %{customer_order_line: customer_order_line}
  end
end
