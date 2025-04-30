defmodule United.Settings.PageVisitor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "page_visitors" do
    field :email, :string
    # field :facebook_page_id, :integer
    belongs_to(:facebook_page, United.Settings.FacebookPage)
    field :name, :string
    field :phone, :string
    field :profile_pic, :binary
    field :psid, :string
    has_many(:customer_orders, United.Settings.CustomerOrder)

    timestamps()
  end

  @doc false
  def changeset(page_visitor, attrs) do
    page_visitor
    |> cast(attrs, [:psid, :name, :profile_pic, :email, :phone, :facebook_page_id])
    |> validate_required([:psid])
  end
end
