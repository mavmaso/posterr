defmodule PosterrWeb.UserControllerTest do
  use PosterrWeb.ConnCase, async: true

  import Posterr.Factory

  @invalid_attrs %{username: nil}

  setup %{conn: conn} do
    user = insert(:user)

    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user}
  end

  describe "index" do
    test "lists all users", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :index))

      assert [subject] = json_response(conn, 200)["data"]
      assert subject["id"] == user.id
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      params = params_for(:user)

      conn = post(conn, Routes.user_path(conn, :create), user: params)

      assert %{"id" => _id} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "show user" do
    test "renders user when data is valid", %{conn: conn, user: user} do
      insert_list(5, :post, %{user: user})

      conn = get(conn, Routes.user_path(conn, :show, user.id))

      assert subject = json_response(conn, 200)["data"]
      assert subject["id"] == user.id
      assert subject["username"] == user.username
      assert subject["joined"] == Date.to_string(user.inserted_at)
      assert subject["count_posts"] == 5
    end
  end
end
