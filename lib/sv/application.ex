defmodule SV.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SVWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SV.PubSub},
      # Start the Endpoint (http/https)
      SVWeb.Endpoint
      # Start a worker by calling: SV.Worker.start_link(arg)
      # {SV.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SV.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SVWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
