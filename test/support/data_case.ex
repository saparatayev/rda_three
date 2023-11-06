defmodule RdaThree.Support.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Ecto.Changeset
      import RdaThree.Support.DataCase
      alias RdaThree.{Support.Factory, Repo}
    end
  end

  setup _ do
    Ecto.Adapters.SQL.Sandbox.mode(RdaThree.Repo, :manual)
  end
end
