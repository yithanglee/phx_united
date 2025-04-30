defmodule United.Repo.Migrations.AddPriceToBooks do
  use Ecto.Migration

  def change do
    alter table("books") do
      add :price, :float
    end 
  end
end
