defmodule RdaThreeWeb.Router do
  use RdaThreeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RdaThreeWeb do
    pipe_through :api
  end
end
