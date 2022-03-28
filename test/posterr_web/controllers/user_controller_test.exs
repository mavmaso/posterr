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
      insert_list(2, :following, %{user: user})
      insert(:following, %{follow: user})

      conn = get(conn, Routes.user_path(conn, :show, user.id))

      assert subject = json_response(conn, 200)["data"]
      assert subject["id"] == user.id
      assert subject["username"] == user.username
      assert subject["joined"] == Date.to_string(user.inserted_at)
      assert subject["count_posts"] == 5
      assert subject["followers"] == 1
      assert subject["followings"] == 2
    end
  end

  describe "follow" do
    test "renders following if not yet", %{conn: conn, user: user} do
      new_user = insert(:user)
      params = %{"user_id" => user.id, "follow_id" => new_user.id}

      conn = post(conn, Routes.user_path(conn, :follow), params)

      assert json_response(conn, 200)["data"] == "created"
    end

    test "renders :ok when delete followship", %{conn: conn, user: user} do
      new_user = insert(:user)
      insert(:following, %{user: user, follow: new_user})
      params = %{"user_id" => user.id, "follow_id" => new_user.id}

      conn = post(conn, Routes.user_path(conn, :follow), params)

      assert json_response(conn, 200)["data"] == "ok"
    end

    test "render :error when followed user don't exist", %{conn: conn, user: user} do
      params = %{"user_id" => user.id, "follow_id" => 0}

      conn = post(conn, Routes.user_path(conn, :follow), params)

      assert json_response(conn, 404)["errors"]["detail"] == "Not Found"
    end

    test "render :error when user don't exist", %{conn: conn} do
      new_user = insert(:user)
      params = %{"user_id" => 0, "follow_id" => new_user}

      conn = post(conn, Routes.user_path(conn, :follow), params)

      assert json_response(conn, 404)["errors"]["detail"] == "Not Found"
    end

    test "renders :error when following themselves", %{conn: conn, user: user} do
      params = %{"user_id" => user.id, "follow_id" => user.id}

      conn = post(conn, Routes.user_path(conn, :follow), params)

      assert json_response(conn, 400)["errors"] == "user can't following themselves"
    end
  end
end
