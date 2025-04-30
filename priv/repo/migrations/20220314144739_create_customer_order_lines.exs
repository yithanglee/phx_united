defmodule United.Repo.Migrations.CreateCustomerOrderLines do
  use Ecto.Migration

  def change do
    create table(:customer_order_lines) do
      add :customer_order_id, references(:customer_orders)
      add :item_name, :string
      add :qty, :integer
      add :cost_price, :float
      add :sub_total, :float
      add :live_comment_id, :integer
      add :remarks, :binary

      timestamps()
    end

  end
end
