defmodule ChitChat.Documents.Upload do
  use Ecto.Schema
  import Ecto.Changeset

  @upload_directory Application.get_env(:chit_chat, :upload_directory)

  schema "uploads" do
    field :content_type, :string
    field :filename, :string
    field :hash, :string
    field :size, :integer
    field :thumbnail?, :boolean, source: :has_thumb

    timestamps()
  end

  @doc false
  def changeset(upload, attrs) do
    upload
    |> cast(attrs, [:filename, :size, :content_type, :hash, :thumbnail?])
    |> validate_required([:filename, :size, :content_type, :hash])
    |> validate_number(:size, greater_than: 0) #doesn't allow empty files
    |> validate_length(:hash, is: 64)
  end

  def sha256(chunks_enum) do
    chunks_enum
    |> Enum.reduce(
        :crypto.hash_init(:sha256),
        &(:crypto.hash_update(&2, &1))
    )
    |> :crypto.hash_final()
    |> Base.encode16()
    |> String.downcase()
  end

  def local_path(filename) do
    [@upload_directory, "#{filename}"]
    |> Path.join()
  end

  def thumbnail_path(filename) do
    filename_noext = Path.rootname(filename)
    IO.inspect(filename_noext)
    [@upload_directory, "thumb-#{filename_noext}.jpg"]
    |> Path.join()
  end

  def mogrify_thumbnail(src_path, dst_path) do
    try do
      Mogrify.open(src_path)
      |> Mogrify.resize_to_limit("300x300")
      |> Mogrify.save(path: dst_path)
    rescue
      File.Error -> {:error, :invalid_src_path}
      error -> {:error, error}
    else
      _image -> {:ok, dst_path}
    end
  end

  def create_thumbnail(%__MODULE__{content_type: "image/" <> _img_type}=upload) do
    original_path = local_path(upload.filename)
    thumb_path = thumbnail_path(upload.filename)
    {:ok, _} = mogrify_thumbnail(original_path, thumb_path)
    changeset(upload, %{thumbnail?: true})
  end

  def create_thumbnail(%__MODULE__{content_type: "application/pdf"}=upload) do
    original_path = local_path(upload.filename)
    thumb_path = thumbnail_path(upload.filename)
    {:ok, _} = pdf_thumbnail(original_path, thumb_path)
    changeset(upload, %{thumbnail?: true})
  end


  def create_thumbnail(%__MODULE__{}=upload), do: changeset(upload, %{})

  def pdf_thumbnail(pdf_path, thumb_path) do
    args = ["-density", "300", "-resize",
            "300x300","#{pdf_path}[0]",
            thumb_path]

    case System.cmd("convert", args, stderr_to_stdout: true) do
      {_, 0} -> {:ok, thumb_path}
      {reason, _} -> {:error, reason}
    end
  end

end
