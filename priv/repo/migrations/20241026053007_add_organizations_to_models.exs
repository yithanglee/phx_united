defmodule United.Repo.Migrations.AddOrganizationsToModels do
  use Ecto.Migration

  def change do
    alter table("members") do
      add :organization_id, :integer
    end


    alter table("groups") do
      add :organization_id, :integer
    end


    alter table("books") do
      add :organization_id, :integer
    end


    alter table("book_inventories") do
      add :organization_id, :integer
    end


    alter table("loans") do
      add :organization_id, :integer
    end


    alter table("book_categories") do
      add :organization_id, :integer
    end


    alter table("email_reminders") do
      add :organization_id, :integer
    end
  end
end
