defmodule ChitChatWeb.Pow.Mailer do
  use Pow.Phoenix.Mailer
  require Logger

  def cast(%{user: user, subject: subject, text: text, html: html, assigns: _assigns}) do
    # Build email struct to be used in `process/1`

    %{to: user.email, subject: subject, text: text, html: html}
  end

  def process(email) do
    # Send email
    IO.inspect("E-mail sent: #{inspect email}")
    Logger.debug("E-mail sent: #{inspect email}")
  end
end
