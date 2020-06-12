defmodule ChitChatWeb.UploadAdmin do
  alias ChitChat.Documents

  def insert(conn, changeset) do
    IO.inspect("UploadAdmin:: CUSTOM INSERT")
    IO.inspect(conn.params["upload"]["filename"])
    {:ok, res_upload} = Documents.create_upload(conn.params["upload"]["filename"])
    IO.inspect(res_upload)
    {:ok, res_upload}
  end

  def update(conn, changeset) do
    IO.inspect("UploadAdmin:: CUSTOM UPDATE")
    IO.inspect(conn.params["id"])
    IO.inspect(conn.params["upload"]["filename"])
    {:ok, res_upload} = Documents.update_upload(conn.params["id"], conn.params["upload"]["filename"])
    IO.inspect(res_upload)
    {:ok, res_upload}
  end

  def delete(conn, changeset) do
    IO.inspect("UploadAdmin:: CUSTOM DELETE")
    IO.inspect(conn)
    upload = Documents.get_upload!(conn.params["id"])
    upload |> Repo.update()
    {:ok, upload}
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
