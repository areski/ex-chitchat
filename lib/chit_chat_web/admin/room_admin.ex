defmodule ChitChatWeb.RoomAdmin do
  alias ChitChat.Accounts

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
        title: "Room usage",
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
      description: nil,
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
      date: %{
        name: "Date Added",
        value: fn p -> NaiveDateTime.to_string(p.inserted_at) end
      },
    ]
  end

end
