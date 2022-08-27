defmodule Snippex.Repo.Migrations.CreateSnippets do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false

      timestamps()
    end

    create table(:snippets) do
      add :lang, :string, null: false
      add :code, :string, null: false
      add :deps, :map, null: false, default: %{}
      add :lang_version, :string, null: false
      add :otp_version, :string, null: false
      add :user_id, references(:users)

      timestamps()
    end

    index(:snippets, [:lang])
    index(:snippets, [:user_id])
  end
end
