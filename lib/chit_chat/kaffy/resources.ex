defmodule ChitChat.Kaffy.Resources do
  def build_resources(_conn) do
    [
      user: [
        name: "User", # a custom name for this context/section.
        resources: [
          user: [schema: ChitChat.Accounts.User, admin: ChitChatWeb.UserAdmin],
          credential: [schema: ChitChat.Accounts.Credential, admin: ChitChatWeb.CredentialAdmin],
          # tag: [schema: MyApp.Blog.Tag]
        ]
      ],
      room: [
        name: "Room",
        resources: [
          room: [schema: ChitChat.Chat.Room, admin: ChitChatWeb.RoomAdmin]
        ]
      ],
      blog: [
        name: "Blog",
        resources: [
          post: [schema: ChitChat.Blog.Post, admin: ChitChatWeb.PostAdmin],
          author: [schema: ChitChat.Blog.Author, admin: ChitChatWeb.AuthorAdmin],
          upload: [schema: ChitChat.Documents.Upload, admin: ChitChatWeb.UploadAdmin],
        ]
      ]
    ]
  end
end
