defmodule United.Repo.Migrations.AddUserAccessTokenToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :user_access_token, :string 
add :fb_user_id, :string 
add :fb_psid, :string
    end
  end
end
