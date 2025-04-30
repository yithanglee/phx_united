defmodule United.Settings.CustomerOrder do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  defenum(
    StatusEnum,
    ~w(
      pending_confirmation
      pending_payment
      paid
      complete
      refund
      canceled
    )
  )

  defenum(
    PaymentMethodEnum,
    ~w(
    cod bank_in online_payment
    )
  )

  defenum(
    DeliveryStatusEnum,
    ~w(
      pending_payment
      packing
      sent
      received
    )
  )

  schema "customer_orders" do
    field :date, :date
    field :delivery_address, :string
    field :delivery_fee, :float
    field :delivery_phone, :string
    field(:payment_method, PaymentMethodEnum, default: :online_payment)
    field :delivery_method, :string
    field :delivery_status, DeliveryStatusEnum, default: :pending_payment
    # field :facebook_page_id, :integer
    belongs_to(:facebook_page, United.Settings.FacebookPage)
    field :grand_total, :float
    # field :page_visitor_id, :integer
    belongs_to(:page_visitor, United.Settings.PageVisitor)
    field :payment_gateway_link, :string
    field :receipt_upload_link, :string
    field :remarks, :binary
    field :status, StatusEnum, default: :pending_confirmation
    field :sub_total, :float
    field :user_id, :integer
    field :live_video_id, :integer
    has_many(:customer_order_lines, United.Settings.CustomerOrderLine)
    field :external_id, :string

    timestamps()
  end

  @doc false
  def changeset(customer_order, attrs) do
    customer_order
    |> cast(attrs, [
      :external_id,
      :live_video_id,
      :delivery_method,
      :delivery_status,
      :page_visitor_id,
      :date,
      :delivery_address,
      :delivery_phone,
      :delivery_fee,
      :sub_total,
      :grand_total,
      :user_id,
      :status,
      :payment_gateway_link,
      :receipt_upload_link,
      :remarks,
      :facebook_page_id
    ])
    |> validate_required([
      :page_visitor_id,
      :date
    ])
  end
end
