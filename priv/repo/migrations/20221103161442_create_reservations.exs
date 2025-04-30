defmodule United.Repo.Migrations.CreateReservations do
  use Ecto.Migration

  def change do
    create table(:reservations) do
      add :member_id, :integer
      add :book_inventory_id, :integer
      add :status, :string
      add :loan_id, :integer

      timestamps()
    end

  end
end
