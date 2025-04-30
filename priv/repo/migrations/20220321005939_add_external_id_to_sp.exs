defmodule United.Repo.Migrations.AddExternalIdToSp do
  use Ecto.Migration

  def change do
    alter table("shop_products") do 
      add :external_id, :string
    end 
  end
end
