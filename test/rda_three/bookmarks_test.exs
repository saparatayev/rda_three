defmodule RdaThree.BookmarksTest do
  use RdaThree.DataCase

  alias RdaThree.Bookmarks

  describe "bookmarks" do
    alias RdaThree.Bookmarks.Bookmark

    import RdaThree.BookmarksFixtures

    @invalid_attrs %{title: nil}

    test "list_bookmarks/0 returns all bookmarks" do
      bookmark = bookmark_fixture()
      assert Bookmarks.list_bookmarks() == [bookmark]
    end

    test "get_bookmark!/1 returns the bookmark with given id" do
      bookmark = bookmark_fixture()
      assert Bookmarks.get_bookmark!(bookmark.id) == bookmark
    end

    test "create_bookmark/1 with valid data creates a bookmark" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Bookmark{} = bookmark} = Bookmarks.create_bookmark(valid_attrs)
      assert bookmark.title == "some title"
    end

    test "create_bookmark/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bookmarks.create_bookmark(@invalid_attrs)
    end

    test "update_bookmark/2 with valid data updates the bookmark" do
      bookmark = bookmark_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Bookmark{} = bookmark} = Bookmarks.update_bookmark(bookmark, update_attrs)
      assert bookmark.title == "some updated title"
    end

    test "update_bookmark/2 with invalid data returns error changeset" do
      bookmark = bookmark_fixture()
      assert {:error, %Ecto.Changeset{}} = Bookmarks.update_bookmark(bookmark, @invalid_attrs)
      assert bookmark == Bookmarks.get_bookmark!(bookmark.id)
    end

    test "delete_bookmark/1 deletes the bookmark" do
      bookmark = bookmark_fixture()
      assert {:ok, %Bookmark{}} = Bookmarks.delete_bookmark(bookmark)
      assert_raise Ecto.NoResultsError, fn -> Bookmarks.get_bookmark!(bookmark.id) end
    end

    test "change_bookmark/1 returns a bookmark changeset" do
      bookmark = bookmark_fixture()
      assert %Ecto.Changeset{} = Bookmarks.change_bookmark(bookmark)
    end
  end
end
