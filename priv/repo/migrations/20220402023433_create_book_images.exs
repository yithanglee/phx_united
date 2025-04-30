defmodule United.Repo.Migrations.CreateBookImages do
  use Ecto.Migration

  def change do
    create table(:book_images) do
      add :book_id, :integer
      add :img_url, :string
      add :group, :string

      timestamps()
    end

  end
end
