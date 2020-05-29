defmodule ChitChat.Blog.PostTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts_tags" do
    field :post_id, :id, null: false, primary_key: true
    field :tag_id, :id, null: false, primary_key: true
  end

  @doc false
  def changeset(post_tag, attrs) do
    post_tag
    |> cast(attrs, [])
    |> validate_required([])
  end
end
