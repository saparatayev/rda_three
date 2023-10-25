defmodule RdaThree.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RdaThree.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        biography: "some biography",
        full_name: "some full_name",
        gender: "some gender"
      })
      |> RdaThree.Users.create_user()

    user
  end
end
