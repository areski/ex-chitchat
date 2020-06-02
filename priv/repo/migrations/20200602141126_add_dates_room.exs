defmodule ChitChat.Repo.Migrations.AddDatesRoom do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      add :naive_booking_date, :naive_datetime
      add :naive_usec_booking_date, :naive_datetime_usec
      add :utc_booking_date, :utc_datetime
      add :utc_usecbooking_date, :utc_datetime_usec
      add :booking_date, :date
      add :booking_time, :time
    end
  end
end
