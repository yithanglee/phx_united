defmodule United.Settings.FacebookPage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "facebook_pages" do
    field :name, :string
    field :page_access_token, :string
    field :page_id, :string
    # field :shop_id, :integer
    belongs_to(:shop, United.Settings.Shop)
    field :user_id, :integer
    field :accounting_organization_id, :integer
    field :accounting_accesss_token, :string
    has_many(:live_videos, United.Settings.LiveVideo, foreign_key: :facebook_page_id)
    timestamps()
  end

  @doc false
  def changeset(facebook_page, attrs) do
    facebook_page
    |> cast(attrs, [
      :accounting_organization_id,
      :accounting_accesss_token,
      :user_id,
      :name,
      :page_id,
      :page_access_token,
      :shop_id
    ])
    |> validate_required([
      :user_id,
      :name,
      :page_id,
      :page_access_token
      # :shop_id
    ])
  end
end
