defmodule United.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do


    create table(:organizations) do
      add :name, :string
      add :desc, :string
      add :address, :string
      add :phone, :string
      add :email, :string
      add :opening_hours, :binary
      add :img_url, :string
      add :background_img_url, :string

      timestamps()
    end

  end
end
