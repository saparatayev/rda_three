defmodule RdaThreeWeb.Router do
  use RdaThreeWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug RdaThreeWeb.Auth.Pipeline
    plug RdaThreeWeb.Auth.SetAccount
  end

  scope "/api", RdaThreeWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/accounts/create", AccountController, :create
    post "/accounts/sign_in", AccountController, :sign_in
  end

  scope "/api", RdaThreeWeb do
    pipe_through [:api, :auth]
    get "/accounts/me", AccountController, :show
  end
end
