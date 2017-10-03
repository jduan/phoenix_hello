defmodule Hello.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :bio, :text
      add :role, :string
      add :genre, :string
      # We used the :delete_all strategy again to enforce data integrity. This
      # way, when a user is deleted from the application through
      # Accounts.delete_user/1), we don’t have to rely on application code in
      # our Accounts context to worry about cleaning up the CMS author records.
      # This keeps our application code decoupled and the data integrity
      # enforcement where it belongs – in the database.
      add :user_id, references(:users, on_delete: :delete_all),
        null: false

      timestamps()
    end

    create unique_index(:authors, [:user_id])
  end
end
