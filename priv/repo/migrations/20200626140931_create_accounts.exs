defmodule ChitChat.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :email, :string, null: false
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:accounts, [:email])
  end
end
