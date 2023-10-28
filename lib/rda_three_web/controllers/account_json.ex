defmodule RdaThreeWeb.AccountJSON do
  alias RdaThree.Accounts.Account
  alias RdaThree.Users.User

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    if account.user do
      %{
        id: account.id,
        email: account.email,
        biography: account.user.biography,
        full_name: account.user.full_name,
        gender: account.user.gender
      }
    else
      user = %User{}

      %{
        id: account.id,
        email: account.email,
        biography: user.biography,
        full_name: user.full_name,
        gender: user.gender
      }
    end
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email,
      hash_password: account.hash_password
    }
  end

  def account_token(%{account: account, token: token}) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end
end
