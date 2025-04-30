defmodule United.Repo.Migrations.AddBookCountToBookCategories do
  use Ecto.Migration

  def change do
    alter table("book_categories") do 
      add :book_count, :integer, default: 0
    end 
  end
end
