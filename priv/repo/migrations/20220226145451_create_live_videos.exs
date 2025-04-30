defmodule United.Repo.Migrations.CreateLiveVideos do
  use Ecto.Migration

  def change do
    create table(:live_videos) do
      add :live_id, :string
      add :facebook_page_id, references(:facebook_pages)
      add :title, :binary
      add :description, :binary
      add :embed_html, :binary
      add :picture, :binary
      add :created_at, :naive_datetime

      timestamps()
    end

  end
end
