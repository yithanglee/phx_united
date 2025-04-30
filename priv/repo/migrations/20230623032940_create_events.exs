defmodule United.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :description, :binary
      add :organiser, :string
      add :short_desc, :string
      add :img_url, :string
      add :date, :date

      timestamps()
    end

  end
end
