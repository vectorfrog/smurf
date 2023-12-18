defmodule Smurf.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SmurfWeb.Telemetry,
      Smurf.Repo,
      {DNSCluster, query: Application.get_env(:smurf, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Smurf.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Smurf.Finch},
      # Start a worker by calling: Smurf.Worker.start_link(arg)
      # {Smurf.Worker, arg},
      # Start to serve requests, typically the last entry
      SmurfWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Smurf.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SmurfWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
