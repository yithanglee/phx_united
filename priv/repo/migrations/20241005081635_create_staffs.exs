defmodule United.Repo.Migrations.CreateStaffs do
  use Ecto.Migration

  def change do
    create table(:staffs) do
      add :organization_id, :integer
      add :role_id, :integer
      add :crypted_password, :string
      add :username, :string
      add :name, :string
      add :email, :string
      add :desc, :string
      add :phone, :string

      timestamps()
    end

  end
end
