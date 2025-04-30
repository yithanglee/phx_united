defmodule United.Settings.Holiday do
  use Ecto.Schema
  import Ecto.Changeset

  schema "holidays" do
    field :event_date, :date
    field :extend_in_days, :integer
    field :remarks, :binary

    timestamps()
  end

  @doc false
  def changeset(holiday, attrs) do
    holiday
    |> cast(attrs, [:event_date, :extend_in_days, :remarks])
    |> validate_required([:event_date, :extend_in_days, :remarks])
  end
end
