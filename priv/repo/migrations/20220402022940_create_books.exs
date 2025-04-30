defmodule United.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :author_id, :integer
      add :publisher_id, :integer
      add :description, :binary

      timestamps()
    end

  end
end
