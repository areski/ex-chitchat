defmodule ChitChatWeb.PostAdmin do


  def published?(p) do
    if (p.published), do: "✅", else: "❌"
  end

  def index(_) do
    [
      id: nil,
      title: nil,
      # published: %{name: "Yes?", value: fn _ -> Enum.random(["Yes", "No"]) end},
      published: %{
        name: "Published?",
        value: fn p -> published?(p) end,
        filters: [{"Published", true}, {"Not Published", false}]
      },
      unique_uuid: nil,
      views: nil,
      date: %{
        name: "Date Added",
        value: fn p -> NaiveDateTime.to_string(p.inserted_at) end
      }
    ]
  end

  def form_fields(_) do
    [
      title: %{label: "Post Title"},
      body: %{type: :textarea, rows: 4},
      published: %{type: :boolean_switch},
      unique_uuid: %{create: :readonly, update: :readonly},
      # unique_uuid: %{create: :editable, update: :editable},
      views: nil,
      # views: %{permission: :read},
      # tags: %{
      #   type: :embed,
      #   # value: fn p -> Accounts.get_user!(p.user_id).name end
      # }
    ]
  end

  def custom_links(_schema) do
    [
      %{name: "Liveview Live Dashboard", url: "http://0.0.0.0:4000/dashboard", order: 2, location: :top, icon: "paperclip"},
      %{name: "Source Code", url: "https://example.com/repo/issues", order: 2, location: :top},
      %{name: "Products On Site", url: "https://example.com/products", location: :sub, icon: "thumbs-up", target: "_blank"},
    ]
  end

end
