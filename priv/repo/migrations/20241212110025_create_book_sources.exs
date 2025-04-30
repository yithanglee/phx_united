defmodule United.Repo.Migrations.CreateBookSources do
  use Ecto.Migration

  def change do
    create table(:book_sources) do
      add :name, :string
      add :desc, :string

      timestamps()
    end

  end
end
