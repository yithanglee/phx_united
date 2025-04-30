defmodule United.Repo.Migrations.AddItemCodeToProducts do
  use Ecto.Migration

  def change do
    alter table("shop_products") do
      add :item_code, :string
    end
  end
end
