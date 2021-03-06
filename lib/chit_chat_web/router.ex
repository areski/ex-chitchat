defmodule ChitChatWeb.Router do
  use ChitChatWeb, :router
  use Kaffy.Routes, scope: "/admin"
  use Pow.Phoenix.Router
  use Pow.Extension.Phoenix.Router,
    extensions: [PowResetPassword, PowEmailConfirmation]
  # , pipe_through: [:some_plug, :authenticate]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ChitChat.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end

  scope "/", ChitChatWeb do
    pipe_through [:browser]

    get "/", PageController, :index
    get "/login", SessionController, :new
    get "/logout", SessionController, :delete


    resources "/uploads", UploadController, only: [:index, :new, :create, :show] do
      get "/thumbnail", UploadController, :thumbnail, as: "thumbnail"
    end
    resources "/rooms", RoomController
    resources "/users", UserController
    resources "/posts", PostController
    resources "/tags", TagController
    resources "/authors", AuthorController
    resources "/sessions", SessionController, only: [:new, :create, :delete], singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChitChatWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ChitChatWeb.Telemetry
    end
  end
end
