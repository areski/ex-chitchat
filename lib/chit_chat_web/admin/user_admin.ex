defmodule ChitChatWeb.UserAdmin do
  def widgets(_schema, _conn) do
    [
      %{
        type: "tidbit",
        title: "Average Reviews",
        content: "4.7 / 5.0",
        icon: "thumbs-up",
        order: 1,
        width: 6,
      },
      %{
        type: "progress",
        title: "Pancakes",
        content: "Customer Satisfaction",
        percentage: 79,
        order: 3,
        width: 6,
      },
      %{
        type: "chart",
        title: "This week's sales",
        order: 8,
        width: 12,
        content: %{
          x: ["Mon", "Tue", "Wed", "Thu", "Today"],
          y: [150, 230, 75, 240, 290],
          y_title: "USD"
        }
      }
    ]
  end

  # def ordering(_schema) do
  #   [desc: :id]
  # end

  def index(_) do
    [
      id: nil,
      name: nil,
      # username: nil,
      username: %{
        name: "Username",
        value: fn p -> p.username end,
        filters: [{"Areski", "areski"}, {"TestUser", "testuser"}]
      },
      # username: %{name: "User?", value: fn _ -> Enum.random(["Yes", "No"]) end},
      date: %{
        name: "Date Added",
        value: fn p -> NaiveDateTime.to_string(p.inserted_at) end
      },
    ]
  end

  def form_fields(_) do
    [
      name: nil,
      username: %{permission: :read},
      status: %{choices: [{"Publish", "publish"}, {"Pending", "pending"}]},
      # body: %{type: :textarea, rows: 4},
      # views: %{permission: :read},
      # settings: %{label: "Post Settings"}
    ]
  end

  def resource_actions(_conn) do
    [
      publish: %{name: "Publish this product", action: fn _c, p -> restock(p) end},
      soldout: %{name: "Sold out!", action: fn _c, p -> soldout(p) end}
    ]
  end

  defp restock(product) do
    update_product(product, %{"username" => "available"})
  end

  defp soldout(product) do
    case product.id == 3 do
      true ->
        {:error, product, "This product should never be sold out!"}

      false ->
        update_product(product, %{"username" => "soldout"})
    end
  end

  defp update_product(product, _opts) do
    IO.inspect(product)
  end


  def list_actions(_conn) do
    [
      soldout: %{name: "Mark as soldout", action: fn _, products -> list_soldout(products) end},
      restock: %{name: "Bring back", action: fn _, products -> list_soldout(products) end},
      not_good: %{name: "Error me out", action: fn _, _ -> {:error, "Expected error"} end}
    ]
  end

  defp list_soldout(_) do

  end

end
