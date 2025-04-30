defmodule United.Repo.Migrations.CreateStoredMedias do
  use Ecto.Migration

  def change do
    create table(:stored_medias) do
      add :name, :string
      add :s3_url, :binary
      add :size, :integer
      add :f_type, :string
      add :f_extension, :string

      timestamps()
    end

  end
end
