defmodule ChitChat.Documents do
  import Ecto.Query, warn: false

  alias ChitChat.Repo
  alias ChitChat.Documents.Upload

  def list_uploads do
    Repo.all(Upload)
  end

  defp upload(tmp_path, filename, content_type, hash) do

    with {:ok, %File.Stat{size: size}} <- File.stat(tmp_path),
    {:ok, upload} <-
      %Upload{} |> Upload.changeset(%{
        filename: filename, content_type: content_type,
        hash: hash, size: size })
      |> Repo.insert(),

    :ok <- File.cp(
        tmp_path,
        Upload.local_path(upload.id, filename)
    )
    do
      {:ok, upload}
    else
      {:error, reason}=error -> error
    end
  end

  # Update creating logic
  def create_upload_from_plug_upload(%Plug.Upload{
    filename: filename,
    path: tmp_path,
    content_type: content_type
  }) do

    hash =
      File.stream!(tmp_path, [], 2048)
      |> Upload.sha256()

    Repo.transaction fn ->
      with {:ok, upload} = upload(tmp_path, filename, content_type, hash)
      do
        upload
      else
        {:error, reason} -> Repo.rollback(reason)
      end
    end


  end

end
