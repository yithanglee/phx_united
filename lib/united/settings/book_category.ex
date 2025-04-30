defmodule United.Settings.BookCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "book_categories" do
    field :chinese_name, :string
    field :code, :string
    field :description, :binary
    field :name, :string
    field :book_count, :integer, default: 0

    has_many :book_inventories, United.Settings.BookInventory
    belongs_to :organization, United.Settings.Organization
    timestamps()
  end

  @doc false
  def changeset(book_category, attrs) do
    book_category
    |> cast(attrs, [:book_count, :name, :code, :chinese_name, :description, :organization_id])

    # |> validate_required([:name, :code, :chinese_name, :description])
  end
end
