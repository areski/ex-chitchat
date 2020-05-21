defmodule ChitChatWeb.RoomAdmin do
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
end
