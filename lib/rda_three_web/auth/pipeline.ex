defmodule RdaThreeWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :rda_three,
  module: RdaThreeWeb.Auth.Guardian,
  error_handler: RdaThreeWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
