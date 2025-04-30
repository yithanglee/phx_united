defmodule United.Repo.Migrations.AddPaymentMethodToCo do
  use Ecto.Migration

  def change do
    alter table("customer_orders") do 
      add :payment_method, :string
    end 
  end
end
