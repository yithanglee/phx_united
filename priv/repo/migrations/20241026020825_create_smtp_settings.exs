defmodule United.Repo.Migrations.CreateSmtpSettings do
  use Ecto.Migration

  def change do
    create table(:smtp_settings) do
      add :organization_id, :integer
      add :server, :string
      add :hostname, :string
      add :username, :string
      add :password, :string
      add :crypted_password, :string

      timestamps()
    end

  end
end
