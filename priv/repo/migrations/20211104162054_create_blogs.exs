defmodule United.Repo.Migrations.CreateBlogs do
  use Ecto.Migration

  def change do
    create table(:blogs) do
      add :title, :string
      add :excerpt, :string
      add :author, :string
      add :body, :binary

      timestamps()
    end

  end
end
