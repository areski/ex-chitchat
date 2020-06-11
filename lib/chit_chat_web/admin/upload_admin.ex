defmodule ChitChatWeb.UploadAdmin do
  alias ChitChat.Documents

  def overwritten_create(conn, changeset) do
    IO.inspect("In overwritten_create...")
    IO.inspect(conn.params["upload"]["filename"])
    {:ok, res_upload} = Documents.create_upload_from_plug_upload(conn.params["upload"]["filename"])
    IO.inspect(res_upload)
    {:ok, res_upload}
  end

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
