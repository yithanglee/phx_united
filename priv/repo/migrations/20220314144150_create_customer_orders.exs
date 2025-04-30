defmodule United.Repo.Migrations.CreateCustomerOrders do
  use Ecto.Migration

  def change do
    create table(:customer_orders) do
      add :page_visitor_id, references(:page_visitors)
      add :date, :date
      add :delivery_address, :string
      add :delivery_phone, :string
      add :delivery_fee, :float
       add :delivery_method, :string
        add :delivery_status, :string
      add :sub_total, :float
      add :grand_total, :float
      add :user_id, references(:users)
      add :status, :string
      add :payment_gateway_link, :string
      add :receipt_upload_link, :string
      add :remarks, :binary
      add :facebook_page_id, references(:facebook_pages)

      timestamps()
    end

  end
end
