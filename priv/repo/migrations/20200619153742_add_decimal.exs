defmodule ChitChat.Repo.Migrations.AddDecimal do
  use Ecto.Migration

  def change do

    alter table(:rooms) do
      add :cost, :decimal
    end

  end
end
