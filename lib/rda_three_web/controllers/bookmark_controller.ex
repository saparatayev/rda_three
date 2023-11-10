defmodule RdaThreeWeb.BookmarkController do
  use RdaThreeWeb, :controller

  alias RdaThree.Bookmarks
  alias RdaThree.Bookmarks.Bookmark

  action_fallback RdaThreeWeb.FallbackController

  def index(conn, _params) do
    bookmarks = Bookmarks.list_bookmarks()
    render(conn, :index, bookmarks: bookmarks)
  end

  def create(conn, %{"bookmark" => bookmark_params}) do
    with {:ok, %Bookmark{} = bookmark} <- Bookmarks.create_bookmark(bookmark_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/bookmarks/#{bookmark}")
      |> render(:show, bookmark: bookmark)
    end
  end

  def show(conn, %{"id" => id}) do
    bookmark = Bookmarks.get_bookmark!(id)
    render(conn, :show, bookmark: bookmark)
  end

  def update(conn, %{"id" => id, "bookmark" => bookmark_params}) do
    bookmark = Bookmarks.get_bookmark!(id)

    with {:ok, %Bookmark{} = bookmark} <- Bookmarks.update_bookmark(bookmark, bookmark_params) do
      render(conn, :show, bookmark: bookmark)
    end
  end

  def delete(conn, %{"id" => id}) do
    bookmark = Bookmarks.get_bookmark!(id)

    with {:ok, %Bookmark{}} <- Bookmarks.delete_bookmark(bookmark) do
      send_resp(conn, :no_content, "")
    end
  end
end
