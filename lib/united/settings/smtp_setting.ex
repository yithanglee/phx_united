defmodule United.Settings.SmtpSetting do
  use Ecto.Schema
  import Ecto.Changeset

  schema "smtp_settings" do
    field :hostname, :string
    # field :organization_id, :integer
    belongs_to(:organization, United.Settings.Organization)
    field :crypted_password, :string
    field :server, :string
    field :username, :string
    field :password, :string, virtual: true

    field :adapter_type, :string, default: "smtp"
    timestamps()
  end

  @doc false
  def changeset(smtp_setting, attrs) do
    smtp_setting
    |> cast(attrs, [
      :adapter_type,
      :organization_id,
      :server,
      :hostname,
      :username,
      :password,
      :crypted_password
    ])
    |> validate_required([
      :organization_id
      # :server,
      # :hostname,
      # :username,
      # :password,
      # :virtual_password
    ])
  end
end
