defmodule ChitChat.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :unique_uuid, Ecto.UUID
    field :title, :string
    field :body, :string
    field :published, :boolean, default: true
    field :views, :integer, default: 0

    many_to_many :tags, ChitChat.Blog.Tag, join_through: "posts_tags"

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :views, :unique_uuid, :published])
    |> validate_required([:title, :body, :views, :unique_uuid, :published])
    |> default_unique_uuid()
  end

  defp default_unique_uuid(changeset) do
    case get_field(changeset, :unique_uuid) do
      nil -> put_change(changeset, :unique_uuid, gen_unique_uuid())
      "" -> put_change(changeset, :unique_uuid, gen_unique_uuid())
        _ -> changeset
    end
  end

  defp gen_unique_uuid() do
    Ecto.UUID.generate()
  end
end
