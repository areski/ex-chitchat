defmodule ChitChat.Documents do
  import Ecto.Query, only: [from: 1, order_by: 2]

  alias ChitChat.Repo
  alias ChitChat.Documents.Upload
  alias ChitChat.Documents

  @upload_directory Application.get_env(:chit_chat, :upload_directory)

  def get_upload!(id) do
    Upload
    |> Repo.get!(id)
  end

  def list_uploads do
    Upload |> order_by(desc: :id) |> Repo.all
  end

  def list_uploads_full do
    res = list_uploads
    |> add_full_filepath
  end

  defp add_full_filepath(uploads) do
    Enum.map(uploads, fn up ->
      Map.put up, :full_filepath, "#{@upload_directory}/#{up.filename}"
    end)
  end

  defp get_unique_filename(filename) do
    {:ok, Ecto.UUID.generate() <> "-" <> filename}
  end

  defp get_file_info(tmp_path) do
    hash = File.stream!(tmp_path, [], 2048) |> Upload.sha256()
    with {:ok, %File.Stat{size: size}} <- File.stat(tmp_path)
    do
      {:ok, [hash, size]}
    else
      {:error, reason}=error -> error
    end
  end

  defp pre_upload_file(tmp_path, filename, content_type) do
    File.cp(tmp_path, Upload.local_path(filename))
    Upload.create_thumbnail(content_type, filename)
    {:ok, ''}
  end

  def create_upload(%Plug.Upload{filename: filename, path: tmp_path, content_type: content_type}) do
    {:ok, filename} = get_unique_filename(filename)
    {:ok, [hash, size]} = get_file_info(tmp_path)
    {:ok, _} = pre_upload_file(tmp_path, filename, content_type)

    with {:ok, upload} <-
      %Upload{} |> Upload.changeset(%{
        filename: filename, content_type: content_type,
        hash: hash, size: size, thumbnail?: true })
      |> Repo.insert()
    do
      {:ok, upload}
    else
      {:error, reason}=error -> error
    end
  end

  def update_upload(upload_id, %Plug.Upload{filename: filename, path: tmp_path, content_type: content_type}) do
    {:ok, filename} = get_unique_filename(filename)
    {:ok, [hash, size]} = get_file_info(tmp_path)
    {:ok, _} = pre_upload_file(tmp_path, filename, content_type)

    with upload <- Documents.get_upload!(upload_id),
      {:ok, upload} <-
        upload |> Upload.changeset(%{
        filename: filename, content_type: content_type,
        hash: hash, size: size, thumbnail?: true })
      |> Repo.update()
    do
      {:ok, upload}
    else
      {:error, reason}=error -> error
    end
  end

end
