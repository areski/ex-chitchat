defmodule ChitChat.Repo.Migrations.AddAuthorUrl do
  use Ecto.Migration

  def change do
    alter table(:authors) do
      add :url, :string
    end
  end
end
