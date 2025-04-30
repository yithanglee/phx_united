defmodule United.Settings.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :date, :date
    field :description, :binary
    field :img_url, :string
    field :name, :string
    field :organiser, :string
    field :short_desc, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :description, :organiser, :short_desc, :img_url, :date])
    |> validate_required([:name, :description, :organiser, :short_desc, :img_url, :date])
  end
end
