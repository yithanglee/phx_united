defmodule United.Repo.Migrations.AddLiveIdToVideoComments do
  use Ecto.Migration

  def change do
    alter table("video_comments") do
      add :live_video_id, references(:live_videos)
    end
  end
end
