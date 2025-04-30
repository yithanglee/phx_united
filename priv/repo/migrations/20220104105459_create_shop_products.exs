defmodule United.Repo.Migrations.CreateShopProducts do
  use Ecto.Migration

  def change do
    create table(:shop_products) do
      add :cost_price, :float
      add :long_desc, :binary
      add :short_desc, :binary
      add :name, :string
      add :promo_price, :float
      add :retail_price, :float
      add :shop_id, references(:shops)

      timestamps()
    end

  end
end
