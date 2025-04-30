defmodule United.Repo.Migrations.AddExternalIdToCo do
  use Ecto.Migration

  def change do
alter table("customer_orders") do 
add :external_id, :string
end 
  end
end
