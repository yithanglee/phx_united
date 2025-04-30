defmodule United.Settings.BookImage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "book_images" do
    # field :book_id, :integer
    belongs_to(:book, United.Settings.Book)
    field :group, :string
    field :img_url, :string
    has_one(:author, through: [:book, :author])
    has_one(:publisher, through: [:book, :publisher])

    timestamps()
  end

  @doc false
  def changeset(book_image, attrs) do
    # here process the plug and upload to s3?
    book_image
    |> cast(attrs, [:book_id, :img_url, :group])
    |> validate_required([:book_id, :img_url])
  end
end
