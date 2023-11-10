defmodule RdaThree.Repo.Migrations.CreateBookmarks do
  use Ecto.Migration

  def change do
    create table(:bookmarks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :link_id, references(:links, on_delete: :nothing, type: :binary_id)
      add :account_id, references(:accounts, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:bookmarks, [:link_id])
    create index(:bookmarks, [:account_id])
  end
end
