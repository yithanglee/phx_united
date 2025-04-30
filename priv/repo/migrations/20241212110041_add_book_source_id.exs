defmodule United.Repo.Migrations.AddBookSourceId do
  use Ecto.Migration

  def change do
    alter table("book_inventories") do
      add :book_source_id, references(:book_sources)
    end
  end
end
