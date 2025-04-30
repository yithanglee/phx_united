defmodule United.Settings.Shop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shops" do
    field :address, :string
    field :description, :binary
    field :email, :string
    field :img_url, :string
    field :name, :string
    field :phone, :string
    field :accounting_organization_id, :integer
    field :accounting_accesss_token, :string
    timestamps()
  end

  @doc false
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, [
      :accounting_organization_id,
      :accounting_accesss_token,
      :address,
      :description,
      :email,
      :img_url,
      :name,
      :phone
    ])

    # |> validate_required([:address, :description, :email, :img_url, :name, :phone])
  end
end
