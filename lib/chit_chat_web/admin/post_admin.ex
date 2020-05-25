defmodule ChitChatWeb.PostAdmin do

  def index(_) do
    [
      id: nil,
      title: nil,
      published: nil,
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
      published: nil,
      unique_uuid: %{create: :readonly, update: :readonly},
      # unique_uuid: %{create: :editable, update: :editable},
      views: nil,
      # views: %{permission: :read},
    ]
  end

end
