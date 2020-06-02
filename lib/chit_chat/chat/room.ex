defmodule ChitChat.Chat.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :name, :string
    field :description, :string
    belongs_to :user, ChitChat.Accounts.User

    field :naive_booking_date, :naive_datetime

    field :naive_usec_booking_date, :naive_datetime_usec
    field :utc_booking_date, :utc_datetime
    field :utc_usecbooking_date, :utc_datetime_usec
    field :booking_date, :date
    field :booking_time, :time

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :description, :user_id, :naive_booking_date, :naive_usec_booking_date, :utc_booking_date, :utc_usecbooking_date, :booking_date, :booking_time])
    |> validate_required([:name, :description, :user_id, :naive_booking_date])
    |> unique_constraint(:name)
  end

  def create_datetime_changeset(struct, attrs \\ %{}) do
    struct
    |> changeset(attrs)
    |> cast(attrs, [:name, :description, :user_id, :naive_booking_date])
  end

  # def format_string_to_date(%{valid?: false} = changeset), do: changeset
  # def format_string_to_date(%{valid?: true, changes: %{inserted_at: inserted_at}} = changeset) do
  #   inserted_at
  # end
  # def format_string_to_date(changeset), do: changeset

end
