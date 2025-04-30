defmodule United.Repo.Migrations.AddPasswordToMembers do
  use Ecto.Migration

  def change do
    alter table("members") do 
      add :crypted_password, :binary 
      add :username, :string 
      add :image_url, :string
    end 
  end
end
