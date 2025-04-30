defmodule United.Settings.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :bio, :binary
    field :crypted_password, :binary
    field :email, :string
    field :full_name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :phone, :string
    field :user_access_token, :string
    field :fb_user_id, :string
    field :fb_psid, :string
    field :image_url, :string
    field :role_id, :integer

    has_many(:facebook_pages, United.Settings.FacebookPage, foreign_key: :user_id)
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :image_url,
      :role_id,
      :fb_user_id,
      :fb_psid,
      :user_access_token,
      :username,
      :full_name,
      :bio,
      :email,
      :phone,
      :crypted_password
    ])

    # |> validate_required([:username, :full_name, :bio, :email, :phone, :password, :crypted_password])
  end
end
