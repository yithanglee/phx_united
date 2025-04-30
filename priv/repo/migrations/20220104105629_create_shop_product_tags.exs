defmodule United.Repo.Migrations.CreateShopProductTags do
  use Ecto.Migration

  def change do
    create table(:shop_product_tags) do
      add :shop_product_id, references(:shop_products)
      add :tag_id, references(:tags)

    end

  end
end
