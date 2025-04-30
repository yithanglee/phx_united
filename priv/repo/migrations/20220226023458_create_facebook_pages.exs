defmodule United.Repo.Migrations.CreateFacebookPages do
  use Ecto.Migration

  def change do
    create table(:facebook_pages) do
      add :user_id, references(:users)
      add :name, :string
      add :page_id, :string
      add :page_access_token, :string
      add :shop_id, references(:shops)

      timestamps()
    end

  end
end
