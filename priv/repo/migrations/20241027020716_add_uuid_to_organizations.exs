defmodule United.Repo.Migrations.AddUuidToOrganizations do
  use Ecto.Migration

  def change do
      execute("CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\"")
      
    alter table("organizations") do
      add :uuid, :uuid, default: fragment("uuid_generate_v4()")
     
      add :host_name, :string 
    end
  end
end
