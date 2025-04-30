defmodule United.Repo.Migrations.AddAdapterTypeToSmtpSettings do
  use Ecto.Migration

  def change do
    alter table("smtp_settings") do
      add :adapter_type, :string, default: "smtp"
    end
  end
end
