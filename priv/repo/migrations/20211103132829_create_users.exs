defmodule United.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :full_name, :string
      add :bio, :binary
      add :email, :string
      add :phone, :string
      add :password, :string
      add :crypted_password, :binary

      timestamps()
    end

  end
end
