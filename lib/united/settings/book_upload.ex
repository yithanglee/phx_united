defmodule United.Settings.BookUpload do
  use Ecto.Schema
  import Ecto.Changeset

  schema "book_uploads" do
    field :failed_lines, :binary
    field :uploaded_by, :integer
    field :failed_qty, :integer
    field :uploaded_qty, :integer
    has_many(:book_inventories, United.Settings.BookInventory)
    belongs_to(:organization, United.Settings.Organization)
    timestamps()
  end

  @doc false
  def changeset(book_upload, attrs) do
    book_upload
    |> cast(attrs, [:organization_id, :uploaded_by, :failed_qty, :failed_lines, :uploaded_qty])

    # |> validate_required([:failed_lines])
  end
end
