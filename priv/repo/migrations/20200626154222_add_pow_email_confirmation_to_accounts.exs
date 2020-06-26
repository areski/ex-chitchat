defmodule ChitChat.Repo.Migrations.AddPowEmailConfirmationToAccounts do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      add :email_confirmation_token, :string
      add :email_confirmed_at, :utc_datetime
      add :unconfirmed_email, :string
    end

    create unique_index(:accounts, [:email_confirmation_token])
  end
end
