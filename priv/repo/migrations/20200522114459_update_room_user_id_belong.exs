defmodule ChitChat.Repo.Migrations.UpdateRoomUserIdBelong do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      # modify :user_id, references(:users, on_delete: :delete_all), null: false
      modify :user_id, references(:user, on_delete: :delete_all),
        from: references(:user, on_delete: :nothing), null: false
    end

    # create table(:rooms) do
    #   add :name, :string
    #   add :description, :text
    #   add :user_id, references(:users, on_delete: :nothing)

    #   timestamps()
    # end

    # create unique_index(:rooms, [:name])
    # create index(:rooms, [:user_id])

  end
end
