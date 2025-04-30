defmodule United.Settings.BookTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "book_tags" do
    field :book_inventory_id, :integer
    field :tag_id, :integer

    timestamps()
  end

  @doc false
  def changeset(book_tag, attrs) do
    book_tag
    |> cast(attrs, [:book_inventory_id, :tag_id])
    |> validate_required([:book_inventory_id, :tag_id])
  end
end
