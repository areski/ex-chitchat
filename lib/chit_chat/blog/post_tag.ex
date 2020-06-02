defmodule ChitChat.Blog.PostTag do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "posts_tags" do
    # field :post_id, :id, null: false, primary_key: true
    # field :tag_id, :id, null: false, primary_key: true
    belongs_to(:post_id, ChitChat.Blog.Post)
    belongs_to(:tag_id, ChitChat.Blog.Tag)
  end

  @doc false
  def changeset(post_tag, attrs) do
    post_tag
    |> cast(attrs, [:post_id, :tag_id])
    |> validate_required([:post_id, :tag_id])
  end
end
