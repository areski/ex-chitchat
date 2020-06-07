
defmodule ChitChatWeb.UploadController do
  use ChitChatWeb, :controller
  alias ChitChat.Documents

  @upload_directory Application.get_env(:chit_chat, :upload_directory)

  def index(conn, _params) do
    uploads = Documents.list_uploads()
    IO.inspect("**************************************************")
    IO.inspect(Application.get_env(:chit_chat, :upload_directory))
    IO.inspect(@upload_directory)

    render(conn, "index.html", [uploads: uploads, upload_directory: @upload_directory])
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"upload" => %Plug.Upload{}=upload}) do
    case Documents.create_upload_from_plug_upload(upload) do

      {:ok, upload}->
        put_flash(conn, :info, "file uploaded correctly")
        redirect(conn, to: Routes.upload_path(conn, :index))

      {:error, reason}->
        put_flash(conn, :error, "error upload file: #{inspect(reason)}")
        render(conn, "new.html")
    end
  end

end
