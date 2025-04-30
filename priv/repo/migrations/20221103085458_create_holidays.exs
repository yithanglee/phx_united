defmodule United.Repo.Migrations.CreateHolidays do
  use Ecto.Migration

  def change do
    create table(:holidays) do
      add :event_date, :date
      add :extend_in_days, :integer
      add :remarks, :binary

      timestamps()
    end

  end
end
