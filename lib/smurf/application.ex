defmodule Smurf.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @rat_server {Ratatouille.Runtime.Supervisor,
               runtime: [
                 app: SmurfTui,
                 shutdown: {:application, :smurf},
                 quit_events: [{:key, Ratatouille.Constants.key(:ctrl_d)}]
               ]}

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Smurf.Worker.start_link(arg)
      # {Smurf.Worker, arg}
      {Smurf.Repo, []},
      @rat_server
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Smurf.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def stop(_state) do
    # do a hard shutdown after the app is stopped
    System.halt()
  end
end
