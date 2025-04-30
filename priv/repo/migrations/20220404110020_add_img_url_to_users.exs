defmodule United.Repo.Migrations.AddImgUrlToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do 
      add :image_url, :string 
      add :role_id, :integer

    end 
  end
end
