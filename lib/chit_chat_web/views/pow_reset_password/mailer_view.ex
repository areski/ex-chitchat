defmodule ChitChatWeb.PowResetPassword.MailerView do
  use ChitChatWeb, :mailer_view

  def subject(:reset_password, _assigns), do: "Reset password link"
end
