defmodule PosterrWeb.PostControllerTest do
  use PosterrWeb.ConnCase, async: true

  import Posterr.Factory

  setup %{conn: conn} do
    user = insert(:user)
    post = insert(:post)

    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user, post: post}
  end

  describe "create" do
    test "renders post when data is valid", %{conn: conn, user: user} do
      params = params_for(:post, %{user: user})
      insert_list(4, :post, %{user: user})

      conn = post(conn, Routes.post_path(conn, :create), post: params)

      assert subject = json_response(conn, 201)["data"]
      assert subject["type"] == "#{params.type}"
      assert subject["content"] == params.content
      assert subject["user"]["id"] == user.id
      assert subject["id"]
    end

    test "renders error when too many post in the same day", %{conn: conn, user: user} do
      params = params_for(:post, %{user: user})
      insert_list(5, :post, %{user: user})

      conn = post(conn, Routes.post_path(conn, :create), post: params)

      assert "too many posts" = json_response(conn, 400)["error"]
    end
  end
end
