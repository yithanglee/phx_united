defmodule United.Settings.PageSection do
  use Ecto.Schema
  import Ecto.Changeset

  schema "page_sections" do
    field :description, :binary

    field :section, :string
    field :subtitle, :binary
    field :title, :binary

    timestamps()
  end

  @doc false
  def changeset(page_section, attrs) do
    page_section
    |> cast(attrs, [:section, :title, :subtitle, :description])

    # |> validate_required([:section, :title, :subtitle, :description])
  end
end
