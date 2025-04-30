defmodule United.Settings.Loan do
  use Ecto.Schema
  import Ecto.Changeset

  schema "loans" do
    # field :book_inventory_id, :integer

    belongs_to(:organization, United.Settings.Organization)
    belongs_to(:book_inventory, United.Settings.BookInventory)
    has_one(:book, through: [:book_inventory, :book])
    field :has_extended, :boolean, default: false
    field :has_return, :boolean, default: false
    field :loan_date, :date
    # field :member_id, :integer
    belongs_to(:member, United.Settings.Member)
    field :return_date, :date

    timestamps()
  end

  @doc false
  def changeset(loan, attrs) do
    loan
    |> cast(attrs, [
      :organization_id,
      :loan_date,
      :return_date,
      :book_inventory_id,
      :member_id,
      :has_return,
      :has_extended
    ])
    |> validate_required([:loan_date, :return_date, :book_inventory_id, :member_id])
  end
end
