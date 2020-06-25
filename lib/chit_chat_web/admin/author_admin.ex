defmodule ChitChatWeb.AuthorAdmin do

  def ordering(_schema) do
    [desc: :email]
  end

  def index(_) do
    [
      id: nil,
      name: nil,
      email: nil,
      super_author: nil,
      url: nil,
    ]
  end

  # def form_fields(_) do
  #   [
  #     title: %{label: "Post Title"},
  #     body: %{type: :textarea, rows: 4},
  #     published: %{type: :boolean_switch},
  #     unique_uuid: %{create: :readonly, update: :readonly},
  #     # unique_uuid: %{create: :editable, update: :editable},
  #     views: nil,
  #     # views: %{permission: :read},
  #     # tags: %{
  #     #   type: :embed,
  #     #   # value: fn p -> Accounts.get_user!(p.user_id).name end
  #     # }
  #   ]
  # end

end
