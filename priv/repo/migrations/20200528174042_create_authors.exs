defmodule ChitChat.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :name, :string
      add :email, :text
      add :super_author, :boolean, default: false, null: false

      timestamps()
    end

  end
end
