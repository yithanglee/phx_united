defmodule United.Repo.Migrations.CreateEmailReminders do
  use Ecto.Migration

  def change do
    create table(:email_reminders) do
      add :member_id, :integer
      
      add :content, :binary
      add :status, :string, default: "pending"
      add :is_sent, :boolean, default: false

      timestamps()
    end

  end
end
