defmodule ChitChatWeb.UploadAdmin do
  alias ChitChat.Documents
  alias ChitChat.Repo

  def insert(conn, changeset) do
    {:ok, res_upload} = Documents.create_upload(conn.params["upload"]["filename"])
    {:ok, res_upload}
  end

  def update(conn, changeset) do
    {:ok, res_upload} = Documents.update_upload(conn.params["id"], conn.params["upload"]["filename"])
    {:ok, res_upload}
  end

  def delete(conn, changeset) do
    upload = Documents.get_upload!(conn.params["id"])
    upload |> Repo.delete()
    {:ok, upload}
  end

  def index(_) do
    [
      id: nil,
      filename: nil,
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
