defmodule Av3.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Av3.Repo,
      # Start the Telemetry supervisor
      Av3Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Av3.PubSub},
      # Start the Endpoint (http/https)
      Av3Web.Endpoint
      # Start a worker by calling: Av3.Worker.start_link(arg)
      # {Av3.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Av3.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Av3Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
