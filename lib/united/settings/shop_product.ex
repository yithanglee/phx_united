defmodule United.Settings.ShopProduct do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shop_products" do
    field :cost_price, :float
    field :long_desc, :binary
    field :name, :string
    field :promo_price, :float
    field :retail_price, :float
    field :shop_id, :integer
    field :short_desc, :binary
    field :item_code, :string
    field :external_id, :string
    timestamps()
  end

  @doc false
  def changeset(shop_product, attrs) do
    shop_product
    |> cast(attrs, [
      :external_id,
      :item_code,
      :cost_price,
      :long_desc,
      :short_desc,
      :name,
      :promo_price,
      :retail_price,
      :shop_id
    ])

    # |> validate_required([:cost_price, :long_desc, :short_desc, :name, :promo_price, :retail_price, :shop_id])
  end
end
