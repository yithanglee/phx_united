defmodule United.Repo.Migrations.AddFeaturedImageToBlogs do
  use Ecto.Migration

  def change do
  	alter table("blogs") do
  		add :featured_image, :string
  	end
  end
end
