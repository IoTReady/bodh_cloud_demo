defmodule BodhCloud.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = Application.get_env(:libcluster, :topologies) || []

    children = [
      # Start the Ecto repository
      BodhCloud.Repo,
      # Start the Telemetry supervisor
      BodhCloudWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BodhCloud.PubSub},
      # Start the Endpoint (http/https)
      BodhCloudWeb.Endpoint,
      # Start a worker by calling: BodhCloud.Worker.start_link(arg)
      # {BodhCloud.Worker, arg}
      {Cluster.Supervisor, [topologies, [name: BodhCloud.ClusterSupervisor]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BodhCloud.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BodhCloudWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
