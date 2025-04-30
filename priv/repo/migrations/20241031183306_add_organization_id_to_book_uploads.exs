defmodule United.Repo.Migrations.AddOrganizationIdToBookUploads do
  use Ecto.Migration

  def change do
    alter table("book_uploads") do
      add :organization_id, references(:organizations)
    end
  end
end
