defmodule United.Settings.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    # field :author_id, :integer
    # field :publisher_id, :integer
    field :price, :float
    field :description, :binary
    field :title, :string
    field :isbn, :string
    field :call_number, :string
    belongs_to(:author, United.Settings.Author, on_replace: :update)
    belongs_to(:publisher, United.Settings.Publisher, on_replace: :update)
    has_many(:book_images, United.Settings.BookImage)
    belongs_to :organization, United.Settings.Organization
    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:call_number, :price, :isbn, :title, :description, :organization_id])
    |> cast_assoc(:author)
    |> cast_assoc(:publisher)
    |> cast_assoc(:book_images)
    |> validate_required([:title])
  end

  def update_changeset(book, attrs) do
    book
    |> cast(attrs, [
      :call_number,
      :isbn,
      :price,
      :title,
      :author_id,
      :publisher_id,
      :description,
      :organization_id
    ])
    |> validate_required([:title])
  end
end
