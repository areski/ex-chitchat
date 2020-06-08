defmodule ChitChatWeb.UploadAdmin do
  alias ChitChat.Documents

  def index(_) do
    [
      id: nil,
      filename: nil,
      # image: nil,
      content_type: nil,
      size: nil,
      inserted_at: nil,
    ]
  end

  def form_fields(_) do
    [
      filename: %{type: :file},
    ]
  end

end
