defmodule United.Repo.Migrations.CreateShops do
  use Ecto.Migration

  def change do
    create table(:shops) do
      add :address, :string
      add :description, :binary
      add :email, :string
      add :img_url, :string
      add :name, :string
      add :phone, :string

      timestamps()
    end

  end
end
