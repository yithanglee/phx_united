defmodule United.Repo.Migrations.AddBookUploadIdToInventory do
  use Ecto.Migration

  def change do
    alter table("book_inventories") do 

        add :book_upload_id, :integer
        # add :book_upload, references(:book_uploads)
    end

    alter table("book_uploads") do
      add :failed_qty, :integer
    end 
  end
end
