defmodule Posterr.BlogTest do
  use Posterr.DataCase, async: true

  import Posterr.Factory

  alias Posterr.Blog

  describe "posts" do
    alias Posterr.Blog.Post

    @invalid_attrs params_for(:post, %{content: "", type: "diff"})

    test "list_posts/0 returns all posts" do
      post = insert(:post)
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = insert(:post)
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      text = Enum.reduce(1..776, "a", fn _, acc ->
        acc <> "a"
      end)
      attrs = params_with_assocs(:post, %{type: "original", content: text})

      assert {:ok, %Post{} = post} = Blog.create_post(attrs)
      assert post.content == attrs.content
      assert post.type == :original
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "create_post/1 with mote than 777 at content" do
      text = Enum.reduce(1..777, "a", fn _, acc ->
        acc <> "a"
      end)
      attr = params_for(:post, %{content: text})

      assert {:error, %Ecto.Changeset{}} = Blog.create_post(attr)
    end

    test "update_post/2 with valid data updates the post" do
      post = insert(:post)
      update_attrs = %{content: "some updated content", type: :repost}

      assert {:ok, %Post{} = post} = Blog.update_post(post, update_attrs)
      assert post.content == "some updated content"
      assert post.type == :repost
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = insert(:post)
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = insert(:post)
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = insert(:post)
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end
end
