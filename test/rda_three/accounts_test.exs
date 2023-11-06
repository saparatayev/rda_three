defmodule RdaThree.AccountsTest do
  alias RdaThree.Accounts
  alias RdaThree.Accounts.Account
  use RdaThree.Support.DataCase

  setup _ do
    Ecto.Adapters.SQL.Sandbox.checkout(RdaThree.Repo)
  end

  describe "create_account/1" do
    test "success: it inserts an account into the db and returns the account" do
      params = Factory.string_params_for(:account)

      assert {:ok, %Account{} = returned_account} = Accounts.create_account(params)

      account_from_db = Repo.get(Account, returned_account.id)

      assert returned_account == account_from_db

      mutated = ["hash_password"]

      for {param_field, expected} <- params, param_field not in mutated do
        schema_field = String.to_existing_atom(param_field)
        actual = Map.get(account_from_db, schema_field)

        assert actual == expected,
               "Values didn't match for field: #{param_field}\nexpected: #{expected}\nactual: #{actual}"
      end

      assert Bcrypt.verify_pass(params["hash_password"], returned_account.hash_password),
             "Password: #{inspect(params["hash_password"])} doesn't match\nhash: #{inspect(returned_account.hash_password)}"

      assert account_from_db.inserted_at == account_from_db.updated_at
    end

    test "error: returns an error tuple when account can't be created" do
      missing_params = %{}

      assert {:error, %Changeset{valid?: false}} = Accounts.create_account(missing_params)
    end
  end
end
