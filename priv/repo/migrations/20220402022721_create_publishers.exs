defmodule United.Repo.Migrations.CreatePublishers do
  use Ecto.Migration

  def change do
    create table(:publishers) do
      add :name, :string
      add :bio, :binary

      timestamps()
    end

  end
end
