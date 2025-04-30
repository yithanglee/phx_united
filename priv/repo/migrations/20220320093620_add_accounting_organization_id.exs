defmodule United.Repo.Migrations.AddAccountingOrganizationId do
  use Ecto.Migration

  def change do
    alter table("shops") do
      add :accounting_organization_id, :integer
      add :accounting_accesss_token, :string
    end

    alter table("facebook_pages") do
      add :accounting_organization_id, :integer
      add :accounting_accesss_token, :string
    end
  end
end
