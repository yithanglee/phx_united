defmodule United.Settings.Member do
  use Ecto.Schema
  import Ecto.Changeset

  schema "members" do
    field :address, :string
    field :city, :string
    field :code, :string
    field :email, :string

    field :gender, :string
    field :religion, :string
    field :fb_user_id, :string
    # field :group_id, :integer
    field :password, :string, virtual: true
    field :crypted_password, :binary
    belongs_to(:group, United.Settings.Group)

    belongs_to :organization, United.Settings.Organization
    field :ic, :string
    field :name, :string
    field :phone, :string
    field :postcode, :string
    field :psid, :string
    field :username, :string
    field :image_url, :string

    field :is_approved, :boolean, default: true
    field :approved_by, :integer
    field :approved_on, :naive_datetime

    field :qrcode, :string
    field :has_check_in, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [
      :organization_id,
      :qrcode,
      :has_check_in,
      :gender,
      :religion,
      :is_approved,
      :approved_on,
      :approved_by,
      :username,
      :image_url,
      :name,
      :address,
      :postcode,
      :crypted_password,
      :city,
      :group_id,
      :fb_user_id,
      :psid,
      :phone,
      :ic,
      :email,
      :code
    ])
    |> validate_required([
      :name,
      # :address,
      # :postcode,
      # :city,
      :group_id,
      # :fb_user_id,
      # :psid,
      :phone,
      :ic,
      # :email,
      :code
    ])
  end
end
