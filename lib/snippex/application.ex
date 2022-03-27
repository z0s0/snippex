defmodule Snippex.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SnippexWeb.Telemetry,
      {Phoenix.PubSub, name: Snippex.PubSub},
      SnippexWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Snippex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    SnippexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
