defmodule United.Repo.Migrations.CreatePageSections do
  use Ecto.Migration

  def change do
    create table(:page_sections) do
      add :section, :string
      add :title, :binary
      add :subtitle, :binary
      add :description, :binary

      timestamps()
    end

  end
end
