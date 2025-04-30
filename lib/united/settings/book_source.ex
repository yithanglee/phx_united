defmodule United.Settings.BookSource do
  use Ecto.Schema
  import Ecto.Changeset

  schema "book_sources" do
    field :desc, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(book_source, attrs) do
    book_source
    |> cast(attrs, [:name, :desc])

    # |> validate_required([:name, :desc])
  end
end
