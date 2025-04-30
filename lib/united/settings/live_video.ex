defmodule United.Settings.LiveVideo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "live_videos" do
    field :created_at, :naive_datetime
    field :description, :binary
    field :embed_html, :binary
    # field :facebook_page_id, :integer
    belongs_to(:facebook_page, United.Settings.FacebookPage, foreign_key: :facebook_page_id)
    field :live_id, :string
    field :picture, :binary
    field :title, :binary
    has_many(:video_comments, United.Settings.VideoComment, foreign_key: :live_video_id)
    timestamps()
  end

  @doc false
  def changeset(live_video, attrs) do
    live_video
    |> cast(attrs, [
      :live_id,
      :facebook_page_id,
      :title,
      :description,
      :embed_html,
      :picture,
      :created_at
    ])
    |> validate_required([
      :live_id,
      :facebook_page_id,
      # :title,
      # :description,
      :embed_html
      # :picture,
      # :created_at
    ])
  end
end
