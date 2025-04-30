defmodule United.Repo.Migrations.AddShopProductIdExternalIdToColines do
  use Ecto.Migration

  def change do
    alter table("customer_order_lines") do 

        add :shop_product_id, references(:shop_products) 
        add :external_id, :string
    end 
  end
end
