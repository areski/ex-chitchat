defmodule ChitChat.Documents do
  import Ecto.Query, only: [from: 1, order_by: 2]

  alias ChitChat.Repo
  alias ChitChat.Documents.Upload

  @upload_directory Application.get_env(:chit_chat, :upload_directory)

  def get_upload!(id) do
    Upload
    |> Repo.get!(id)
  end

  def list_uploads do
    # Repo.all(Upload)
    # query = from up in "uploads"
    # query |> order_by({:desc, :id})
    # Repo.all(query)
    Upload |> order_by(desc: :id) |> Repo.all
  end

  def list_uploads_full do
    res = list_uploads
    |> add_full_filepath
    IO.inspect(res)
    res
  end

  defp add_full_filepath(uploads) do
    Enum.map(uploads, fn up ->
      Map.put up, :full_filepath, "#{@upload_directory}/#{up.id}-#{up.filename}"
    end)
  end

  defp upload_file(tmp_path, filename, content_type, hash) do

    with {:ok, %File.Stat{size: size}} <- File.stat(tmp_path),
    {:ok, upload} <-
      %Upload{} |> Upload.changeset(%{
        filename: filename, content_type: content_type,
        hash: hash, size: size })
      |> Repo.insert(),

    :ok <- File.cp(
        tmp_path,
        Upload.local_path(upload.id, filename)
    ),

    {:ok, upload} <- Upload.create_thumbnail(upload) |> Repo.update()
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
      with {:ok, upload} = upload_file(tmp_path, filename, content_type, hash)
      do
        upload
      else
        {:error, reason} -> Repo.rollback(reason)
      end
    end


  end

end
