defmodule United.Repo.Migrations.CreateBookCategories do
  use Ecto.Migration

  def change do
    create table(:book_categories) do
      add :name, :string
      add :code, :string
      add :chinese_name, :string
      add :description, :binary

      timestamps()
    end

  end
end
