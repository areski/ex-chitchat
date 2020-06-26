defmodule ChitChatWeb.PowEmailConfirmation.MailerView do
  use ChitChatWeb, :mailer_view

  def subject(:email_confirmation, _assigns), do: "Confirm your email address"
end
