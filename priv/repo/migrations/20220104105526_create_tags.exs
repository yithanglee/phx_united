defmodule United.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :desc, :string
      add :name, :string

      timestamps()
    end

  end
end
