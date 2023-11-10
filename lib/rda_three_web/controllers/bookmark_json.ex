defmodule RdaThreeWeb.BookmarkJSON do
  alias RdaThree.Bookmarks.Bookmark

  @doc """
  Renders a list of bookmarks.
  """
  def index(%{bookmarks: bookmarks}) do
    %{data: for(bookmark <- bookmarks, do: data(bookmark))}
  end

  @doc """
  Renders a single bookmark.
  """
  def show(%{bookmark: bookmark}) do
    %{data: data(bookmark)}
  end

  defp data(%Bookmark{} = bookmark) do
    %{
      id: bookmark.id,
      title: bookmark.title
    }
  end
end
