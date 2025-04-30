defmodule United.Settings.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
  end
end
