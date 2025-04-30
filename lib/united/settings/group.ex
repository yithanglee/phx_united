defmodule United.Settings.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :extension_period, :integer
    field :loan_limit, :integer
    field :loan_period, :integer
    field :name, :string
    field :fine_amount, :float, default: 0.50
    field :fine_days, :integer, default: 7
    belongs_to :organization, United.Settings.Organization

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [
      :organization_id,
      :fine_amount,
      :fine_days,
      :name,
      :loan_limit,
      :loan_period,
      :extension_period
    ])
    |> validate_required([:name, :loan_limit, :loan_period, :extension_period])
  end
end
