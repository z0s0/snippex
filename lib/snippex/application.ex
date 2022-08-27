defmodule Snippex.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Snippex.ReadinessAgent, nil},
      SnippexWeb.Telemetry,
      Snippex.Repo,
      {Phoenix.PubSub, name: Snippex.PubSub},
      SnippexWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Snippex.Supervisor]
    ok_pid = Supervisor.start_link(children, opts)
    Snippex.ReadinessAgent.set_ready()

    ok_pid
  end

  @impl true
  def config_change(changed, _new, removed) do
    SnippexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
