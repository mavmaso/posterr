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

      assert "too many posts" = json_response(conn, 400)["errors"]
    end
  end

  describe "index" do
    test "render all posts when valid data", %{conn: conn} do
      params = %{page: 2}
      count = insert_list(10, :post) |> length()

      conn = get(conn, Routes.post_path(conn, :index), params)

      assert subject = json_response(conn, 200)["data"]
      assert [%{"id" => _, "type" => _, "user" => _}] = subject["entries"]
      assert subject["page_number"] == params.page
      assert subject["page_size"] == 10
      assert subject["total_entries"] == count + 1
      assert subject["total_pages"] == 2
    end

    test "render followings posts when valid data", %{conn: conn, user: user} do
      new_user = insert(:user)
      count = insert_list(8, :post, %{user: new_user}) |> length()
      insert(:following, %{user: user, follow: new_user})
      insert(:following, %{user: user})
      insert_list(4, :post)

      params = %{page: 1, user_id: user.id}

      conn = get(conn, Routes.post_path(conn, :index), params)

      assert subject = json_response(conn, 200)["data"]
      assert subject["page_number"] == params.page
      assert subject["total_entries"] == count
    end
  end

  describe "user_posts" do
    test "render posts when valid data", %{conn: conn, user: user} do
      params = %{page: 2, user_id: user.id}
      count = insert_list(6, :post, %{user: user}) |> length()

      conn = get(conn, Routes.post_path(conn, :user_post), params)

      assert subject = json_response(conn, 200)["data"]
      assert [%{"id" => _, "type" => _, "user" => _}] = subject["entries"]
      assert subject["page_number"] == params.page
      assert subject["page_size"] == 5
      assert subject["total_entries"] == count
      assert subject["total_pages"] == 2
    end
  end
end
