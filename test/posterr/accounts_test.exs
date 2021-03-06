defmodule Posterr.AccountsTest do
  use Posterr.DataCase, async: true

  import Posterr.Factory

  alias Posterr.Accounts

  describe "users" do
    alias Posterr.Accounts.User

    @invalid_attrs %{username: "user-12345"}

    test "list_users/0 returns all users" do
      user = insert(:user)
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user)
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      params = params_for(:user)

      assert {:ok, %User{} = user} = Accounts.create_user(params)
      assert user.username == params.username
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = insert(:user)
      update_attrs = %{username: "some updated username"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert(:user)
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = insert(:user)
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "following" do
    test "add_follow/1 returns error when duplicate follow" do
      user = insert(:user)
      new_user = insert(:user)
      attrs = %{user_id: user.id, follow_id: new_user.id}

      Accounts.add_follow(attrs)

      assert {:error, %Ecto.Changeset{}} = Accounts.add_follow(attrs)
    end

    test "add_follow/1 returns error when user following themselves" do
      user = insert(:user)
      attrs = %{user_id: user.id, follow_id: user.id}

      assert {:error, %Ecto.Changeset{errors: ["can't be yourself"]}} = Accounts.add_follow(attrs)
    end
  end
end
