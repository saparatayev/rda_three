defmodule RdaThree.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RdaThree.Links` context.
  """

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        url: "some url"
      })
      |> RdaThree.Links.create_link()

    link
  end
end
