defmodule United.Settings.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :bio, :binary
    field :name, :string
    has_many(:book, United.Settings.Book)
    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :bio])
    |> validate_required([:name])
  end
end
