defmodule ChitChat.BlogTest do
  use ChitChat.DataCase

  alias ChitChat.Blog

  describe "posts" do
    alias ChitChat.Blog.Post

    @valid_attrs %{body: "some body", published: true, title: "some title", unique_uuid: "7488a646-e31f-11e4-aace-600308960662", views: 42}
    @update_attrs %{body: "some updated body", published: false, title: "some updated title", unique_uuid: "7488a646-e31f-11e4-aace-600308960668", views: 43}
    @invalid_attrs %{body: nil, published: nil, title: nil, unique_uuid: nil, views: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blog.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.published == true
      assert post.title == "some title"
      assert post.unique_uuid == "7488a646-e31f-11e4-aace-600308960662"
      assert post.views == 42
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Blog.update_post(post, @update_attrs)
      assert post.body == "some updated body"
      assert post.published == false
      assert post.title == "some updated title"
      assert post.unique_uuid == "7488a646-e31f-11e4-aace-600308960668"
      assert post.views == 43
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end
end
