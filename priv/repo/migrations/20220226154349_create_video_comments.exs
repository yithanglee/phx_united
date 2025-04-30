defmodule United.Repo.Migrations.CreateVideoComments do
  use Ecto.Migration

  def change do
    create table(:page_visitors) do
      add :psid, :string
      add :name, :string
      add :profile_pic, :binary
      add :email, :string
      add :phone, :string
      add :facebook_page_id, references(:facebook_pages)

      timestamps()
    end
    create table(:video_comments) do
      add :ms_id, :string
      add :message, :binary
      add :created_at, :naive_datetime
      add :page_visitor_id, references(:page_visitors)

      timestamps()
    end

  end
end
