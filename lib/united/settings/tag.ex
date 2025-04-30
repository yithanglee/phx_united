defmodule United.Settings.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :desc, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:desc, :name])
    |> validate_required([:desc, :name])
  end
end
