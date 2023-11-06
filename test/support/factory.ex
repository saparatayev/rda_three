defmodule RdaThree.Support.Factory do
  alias RdaThree.Accounts.Account
  use ExMachina.Ecto, repo: RdaThree.Repo

  def account_factory do
    %Account{
      email: Faker.Internet.email(),
      hash_password: Faker.Internet.slug()
    }
  end
end
