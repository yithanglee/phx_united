defmodule United.Repo.Migrations.CreateLoans do
  use Ecto.Migration

  def change do
    create table(:loans) do
      add :loan_date, :date
      add :return_date, :date
      add :book_inventory_id, :integer
      add :member_id, :integer
      add :has_return, :boolean, default: false, null: false
      add :has_extended, :boolean, default: false, null: false

      timestamps()
    end

  end
end
