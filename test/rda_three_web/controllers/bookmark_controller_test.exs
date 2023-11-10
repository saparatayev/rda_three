defmodule RdaThreeWeb.BookmarkControllerTest do
  use RdaThreeWeb.ConnCase

  import RdaThree.BookmarksFixtures

  alias RdaThree.Bookmarks.Bookmark

  @create_attrs %{
    title: "some title"
  }
  @update_attrs %{
    title: "some updated title"
  }
  @invalid_attrs %{title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bookmarks", %{conn: conn} do
      conn = get(conn, ~p"/api/bookmarks")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bookmark" do
    test "renders bookmark when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/bookmarks", bookmark: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/bookmarks/#{id}")

      assert %{
               "id" => ^id,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/bookmarks", bookmark: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bookmark" do
    setup [:create_bookmark]

    test "renders bookmark when data is valid", %{conn: conn, bookmark: %Bookmark{id: id} = bookmark} do
      conn = put(conn, ~p"/api/bookmarks/#{bookmark}", bookmark: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/bookmarks/#{id}")

      assert %{
               "id" => ^id,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, bookmark: bookmark} do
      conn = put(conn, ~p"/api/bookmarks/#{bookmark}", bookmark: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bookmark" do
    setup [:create_bookmark]

    test "deletes chosen bookmark", %{conn: conn, bookmark: bookmark} do
      conn = delete(conn, ~p"/api/bookmarks/#{bookmark}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/bookmarks/#{bookmark}")
      end
    end
  end

  defp create_bookmark(_) do
    bookmark = bookmark_fixture()
    %{bookmark: bookmark}
  end
end
