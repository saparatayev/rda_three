defmodule RdaThree.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      RdaThreeWeb.Telemetry,
      # Start the Ecto repository
      RdaThree.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: RdaThree.PubSub},
      # Start the Endpoint (http/https)
      RdaThreeWeb.Endpoint
      # Start a worker by calling: RdaThree.Worker.start_link(arg)
      # {RdaThree.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RdaThree.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RdaThreeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
