defmodule United.Settings.CustomerOrderLine do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customer_order_lines" do
    field :cost_price, :float
    field :customer_order_id, :integer
    field :item_name, :string
    # field :live_comment_id, :integer
    field :qty, :integer
    field :remarks, :binary
    field :sub_total, :float
    belongs_to(:shop_product, United.Settings.ShopProduct)
    # field :shop_product_id, :integer
    field :external_id, :string
    timestamps()
  end

  @doc false
  def changeset(customer_order_line, attrs) do
    customer_order_line
    |> cast(attrs, [
      :shop_product_id,
      :external_id,
      :customer_order_id,
      :item_name,
      :qty,
      :cost_price,
      :sub_total,
      # :live_comment_id,
      :remarks
    ])
    |> validate_required([:customer_order_id, :item_name, :qty, :cost_price, :sub_total, :remarks])
  end
end
