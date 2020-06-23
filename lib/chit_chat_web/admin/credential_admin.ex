defmodule ChitChatWeb.CredentialAdmin do

  def index(_) do
    [
      email: nil,
      user: %{permission: :read},
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
    ]
  end

  def form_fields(_) do
    [
      name: nil,
      username: %{permission: :read},
      status: %{choices: [{"Publish", "publish"}, {"Pending", "pending"}]},
      # user: nil,
      # body: %{type: :textarea, rows: 4},
      # views: %{permission: :read},
      # settings: %{label: "Post Settings"}
    ]
  end

end
