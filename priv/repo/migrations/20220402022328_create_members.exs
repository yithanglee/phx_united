defmodule United.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :name, :string
      add :address, :string
      add :postcode, :string
      add :city, :string
      add :group_id, :integer
      add :fb_user_id, :string
      add :psid, :string
      add :phone, :string
      add :ic, :string
      add :email, :string
      add :code, :string

      timestamps()
    end

  end
end
