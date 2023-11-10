defmodule RdaThree.Bookmarks.Bookmark do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bookmarks" do
    field :title, :string
    field :link_id, :binary_id
    field :account_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(bookmark, attrs) do
    bookmark
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
