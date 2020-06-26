# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chit_chat,
  ecto_repos: [ChitChat.Repo]

# Configures the endpoint
config :chit_chat, ChitChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gGS3NOTzNEB3gjanSarYMN/BjnNiMnSuV/6Jo2EyClhNRk5vg3bt4/O3Pj4H4Bq1",
  render_errors: [view: ChitChatWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ChitChat.PubSub,
  live_view: [signing_salt: "JOOvbotZ"],
  reloadable_compilers: [:gettext, :phoenix, :elixir]
  # reloadable_apps: [:phoenix, :elixir]

config :chit_chat,
  upload_directory: "./uploads/images"

config :chit_chat, :pow,
  user: ChitChat.Accounts.Account,
  repo: ChitChat.Repo,
  extensions: [PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: ChitChatWeb.Pow.Mailer,
  web_module: ChitChatWeb

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] - 2 $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Import kaffy config
import_config "kaffy.exs"
