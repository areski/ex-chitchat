defmodule ChitChat.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :text
      add :views, :integer
      add :unique_uuid, :uuid
      add :published, :boolean, default: false, null: false

      timestamps()
    end

  end
end
