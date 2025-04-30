defmodule United.Settings.VideoComment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "video_comments" do
    field :created_at, :naive_datetime
    field :message, :binary
    field :ms_id, :string
    # field :page_visitor_id, :integer
    belongs_to(:page_visitor, United.Settings.PageVisitor, foreign_key: :page_visitor_id)

    belongs_to(:live_video, United.Settings.LiveVideo, foreign_key: :live_video_id)
    timestamps()
  end

  @doc false
  def changeset(video_comment, attrs) do
    video_comment
    |> cast(attrs, [:live_video_id, :ms_id, :message, :created_at, :page_visitor_id])
    |> validate_required([:ms_id, :created_at, :page_visitor_id])
  end
end
