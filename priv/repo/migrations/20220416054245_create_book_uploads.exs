defmodule United.Repo.Migrations.CreateBookUploads do
  use Ecto.Migration

  def change do
    create table(:book_uploads) do
      add :uploaded_by, :integer
      add :failed_lines, :binary
      add :uploaded_qty, :integer

      timestamps()
    end

  end
end
