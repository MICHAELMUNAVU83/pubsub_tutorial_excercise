defmodule PubsubTutorialExcercise.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PubsubTutorialExcercise.Repo,
      # Start the Telemetry supervisor
      PubsubTutorialExcerciseWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PubsubTutorialExcercise.PubSub},
      # Start the Endpoint (http/https)
      PubsubTutorialExcerciseWeb.Endpoint
      # Start a worker by calling: PubsubTutorialExcercise.Worker.start_link(arg)
      # {PubsubTutorialExcercise.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PubsubTutorialExcercise.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PubsubTutorialExcerciseWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
