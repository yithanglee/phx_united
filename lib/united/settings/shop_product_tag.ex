defmodule United.Settings.ShopProductTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shop_product_tags" do
    field :shop_product_id, :integer
    field :tag_id, :integer
  end

  @doc false
  def changeset(shop_product_tag, attrs) do
    shop_product_tag
    |> cast(attrs, [:shop_product_id, :tag_id])
    |> validate_required([:shop_product_id, :tag_id])
  end
end
