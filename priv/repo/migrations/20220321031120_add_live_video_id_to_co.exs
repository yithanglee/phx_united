defmodule United.Repo.Migrations.AddLiveVideoIdToCo do
  use Ecto.Migration

  def change do
    alter table("customer_orders") do
      add :live_video_id, references(:live_videos)
    end
  end
end
