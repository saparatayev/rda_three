defmodule RdaThree.Repo do
  use Ecto.Repo,
    otp_app: :rda_three,
    adapter: Ecto.Adapters.Postgres
end
