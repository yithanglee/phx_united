defmodule United.Repo.Migrations.AddFineSettingsToGroups do
  use Ecto.Migration

  def change do
    alter table("groups") do
      add :fine_amount, :float, default: 0.50
      add :fine_days, :integer, default: 7
    end
  end
end
