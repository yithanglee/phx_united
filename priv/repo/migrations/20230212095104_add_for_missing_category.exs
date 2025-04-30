defmodule United.Repo.Migrations.AddForMissingCategory do
  use Ecto.Migration

  def change do
    alter table("book_inventories") do
      add :is_missing, :boolean, default: false
    end
  end
end
