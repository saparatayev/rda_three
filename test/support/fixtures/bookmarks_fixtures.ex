defmodule RdaThree.BookmarksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RdaThree.Bookmarks` context.
  """

  @doc """
  Generate a bookmark.
  """
  def bookmark_fixture(attrs \\ %{}) do
    {:ok, bookmark} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> RdaThree.Bookmarks.create_bookmark()

    bookmark
  end
end
