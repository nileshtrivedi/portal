defmodule Studio.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      StudioWeb.Telemetry,
      Studio.Repo,
      {DNSCluster, query: Application.get_env(:studio, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Studio.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Studio.Finch},
      # Start a worker by calling: Studio.Worker.start_link(arg)
      # {Studio.Worker, arg},
      # Start to serve requests, typically the last entry
      StudioWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Studio.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StudioWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
