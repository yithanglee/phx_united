defmodule United.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      add :loan_limit, :integer
      add :loan_period, :integer
      add :extension_period, :integer

      timestamps()
    end

  end
end
