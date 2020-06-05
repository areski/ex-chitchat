defmodule ChitChat.Blog.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :email, :string
    field :name, :string
    field :super_author, :boolean, default: false
    field :url, ChitChat.CustomURLField

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :email, :super_author, :url])
    |> validate_required([:name, :email, :super_author, :url])
  end
end
