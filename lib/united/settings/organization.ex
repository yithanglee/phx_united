defmodule United.Settings.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :address, :string
    field :background_img_url, :string
    field :desc, :string
    field :email, :string
    field :img_url, :string
    field :name, :string
    field :opening_hours, :binary
    field :phone, :string
    field :uuid, Ecto.UUID, autogenerate: true
    has_one(:smtp_setting, United.Settings.SmtpSetting)
    field :host_name, :string
    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [
      :host_name,
      :name,
      :desc,
      :address,
      :phone,
      :email,
      :opening_hours,
      :img_url,
      :background_img_url
    ])

    # |> validate_required([:name, :desc, :address, :phone, :email, :opening_hours, :img_url, :background_img_url])
  end
end
