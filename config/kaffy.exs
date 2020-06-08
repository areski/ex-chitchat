# General application configuration
use Mix.Config

# config :kaffy,
# otp_app: :chit_chat,
# ecto_repo: ChitChat.Repo,
# router: ChitChatWeb.Router


config :kaffy,
  admin_title: "Admin Portal",
  otp_app: :chit_chat,
  ecto_repo: ChitChat.Repo,
  router: ChitChatWeb.Router,
  resources: [
    user: [
      name: "User", # a custom name for this context/section.
      schemas: [
        user: [schema: ChitChat.Accounts.User, admin: ChitChatWeb.UserAdmin],
        credential: [schema: ChitChat.Accounts.Credential, admin: ChitChatWeb.CredentialAdmin],
        # tag: [schema: MyApp.Blog.Tag]
      ]
    ],
    room: [
      name: "Room",
      schemas: [
        room: [schema: ChitChat.Chat.Room, admin: ChitChatWeb.RoomAdmin]
      ]
    ],
    blog: [
      name: "Blog",
      schemas: [
        post: [schema: ChitChat.Blog.Post, admin: ChitChatWeb.PostAdmin],
        author: [schema: ChitChat.Blog.Author, admin: ChitChatWeb.AuthorAdmin],
        upload: [schema: ChitChat.Documents.Upload, admin: ChitChatWeb.UploadAdmin],
      ]
    ]
  ]
