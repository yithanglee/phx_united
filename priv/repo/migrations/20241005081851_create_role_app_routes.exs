defmodule United.Repo.Migrations.CreateRoleAppRoutes do
  use Ecto.Migration

  def change do
    create table(:role_app_routes) do
      add :role_id, :integer
      add :app_route_id, :integer

      timestamps()
    end

  end
end
