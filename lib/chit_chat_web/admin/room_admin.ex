defmodule ChitChatWeb.RoomAdmin do
  alias ChitChat.Accounts

  # def create_changeset(schema, attrs) do
  #   # do whatever you want, must return a changeset
  #   ChitChat.Chat.Room.create_datetime_changeset(schema, attrs)
  # end

  # def update_changeset(schema, attrs) do
  #   # do whatever you want, must return a changeset
  #   ChitChat.Chat.Room.create_datetime_changeset(schema, attrs)
  # end

  def widgets(_schema, _conn) do
    [
      %{
        type: "tidbit",
        title: "Max Test",
        content: "4.7 / 5.0",
        icon: "thumbs-up",
        order: 1,
        width: 6,
      },
      %{
        type: "progress",
        title: "Room",
        content: "Room Availability",
        percentage: 79,
        order: 3,
        width: 6,
      },
      %{
        type: "chart",
        title: "Room's usage",
        order: 0,
        width: 12,
        content: %{
          x: ["Mon", "Tue", "Wed", "Thu", "Today"],
          y: [150, 230, 75, 240, 290],
          y_title: "USD"
        }
      }
    ]
  end

  def index(_) do
    [
      name: nil,
      description: %{type: :textarea, rows: 4},
      user: %{
        value: fn p -> Accounts.get_user!(p.user_id).name end,
        filters: Enum.map(Accounts.list_users(), fn c -> {c.name, c.id} end)
      },
      # username: %{
      #   name: "Username",
      #   value: fn p -> p.username end,
      #   filters: [{"Areski", "areski"}, {"TestUser", "testuser"}]
      # },
      # # username: %{name: "User?", value: fn _ -> Enum.random(["Yes", "No"]) end},
      # date: %{
      #   name: "Date Added",
      #   value: fn p -> NaiveDateTime.to_string(p.inserted_at) end
      # },
      date: %{
        name: "Date",
        value: fn p -> p.naive_booking_date end
      },
    ]
  end


  def form_fields(_) do
    [
      name: nil,
      description: nil,
      # user_id: nil,
      user_id: %{choices: Enum.map(Accounts.list_users(), fn c -> {c.name, c.id} end)},
      # inserted_at: nil,
      naive_booking_date: %{
        type: :naive_datetime
      },
      naive_usec_booking_date: %{type: :naive_datetime_usec},
      utc_booking_date: %{type: :utc_datetime},
      utc_usecbooking_date: %{type: :utc_datetime_usec},
      booking_date: %{type: :date},
      booking_time: %{type: :time},
      # body: %{type: :textarea, rows: 4},
      # views: %{permission: :read},
      # settings: %{label: "Post Settings"}
    ]
  end

end
