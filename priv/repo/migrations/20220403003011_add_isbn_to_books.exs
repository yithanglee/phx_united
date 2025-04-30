defmodule United.Repo.Migrations.AddIsbnToBooks do
  use Ecto.Migration

  def change do
    alter table("books") do
      add :isbn, :string
      add :call_number, :string
    end
  end
end
