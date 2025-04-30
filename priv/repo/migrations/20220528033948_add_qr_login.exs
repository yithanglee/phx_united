defmodule United.Repo.Migrations.AddQrLogin do
  use Ecto.Migration

  def change do
    alter table("members") do
      add :qrcode, :string
      add :has_check_in, :boolean, default: false
    end
  end
end
