defmodule United.Repo.Migrations.CreateBookInventories do
  use Ecto.Migration

  def change do
    create table(:book_inventories) do
      add :book_id, :integer
      add :code, :string
      add :book_category_id, :integer

      timestamps()
    end

  end
end
