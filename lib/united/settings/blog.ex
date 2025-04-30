defmodule United.Settings.Blog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blogs" do
    field :author, :string
    field :body, :binary
    field :excerpt, :string
    field :title, :string

      field :featured_image, :string
    # need a category
    # and tags
    # and a featured image
    timestamps()
  end

  @doc false
  def changeset(blog, attrs) do
    blog
    |> cast(attrs, [:featured_image, :title, :excerpt, :author, :body])
    |> validate_required([:title, :excerpt, :author, :body])
  end
end
