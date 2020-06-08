defmodule ChitChatWeb.UploadAdmin do
  alias ChitChat.Documents


  # def before_create(conn, changeset) do
  #   %Plug.Conn{params: %{"upload" => %{"filename" => %Plug.Upload{}=upload }}} = conn
  #   IO.inspect("before_create===============")
  #   IO.inspect(conn)
  #   IO.inspect(upload)
  #   Documents.create_upload_from_plug_upload(upload)
  # end

  # def create(conn, %{"upload" => %Plug.Upload{}=upload}) do
  #   case Documents.create_upload_from_plug_upload(upload) do

  #     {:ok, upload}->
  #       put_flash(conn, :info, "file uploaded correctly")
  #       redirect(conn, to: Routes.upload_path(conn, :index))

  #     {:error, reason}->
  #       put_flash(conn, :error, "error upload file: #{inspect(reason)}")
  #       render(conn, "new.html")
  #   end
  # end

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
