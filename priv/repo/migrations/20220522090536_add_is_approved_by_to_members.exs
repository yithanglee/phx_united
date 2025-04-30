defmodule United.Repo.Migrations.AddIsApprovedByToMembers do
  use Ecto.Migration

  def change do
    alter table("members") do
       add :is_approved, :boolean, default: false 
       add :approved_by, :integer
       add :approved_on, :naive_datetime
       add :gender, :string 
       add :religion, :string
    end
  end
end
