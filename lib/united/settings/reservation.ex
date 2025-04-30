defmodule United.Settings.Reservation do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  defenum(
    StatusEnum,
    ~w(pending available canceled loaned)
  )

  schema "reservations" do
    # field :book_inventory_id, :integer
    belongs_to :book_inventory, United.Settings.BookInventory
    has_one :book, through: [:book_inventory, :book]
    field :loan_id, :integer
    # field :member_id, :integer
    belongs_to :member, United.Settings.Member
    field :status, StatusEnum, default: :pending

    timestamps()
  end

  @doc false
  def changeset(reservation, attrs) do
    reservation
    |> cast(attrs, [:member_id, :book_inventory_id, :status, :loan_id])
    |> validate_required([:member_id, :book_inventory_id])
  end
end
