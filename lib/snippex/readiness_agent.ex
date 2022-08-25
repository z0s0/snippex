defmodule Snippex.ReadinessAgent do
  use Agent

  @initial_state %{
    ready: false,
    live: true
  }

  def start_link(_), do: Agent.start_link(fn -> @initial_state end, name: __MODULE__)

  def status(), do: Agent.get(__MODULE__, & &1)

  def set_ready(), do: Agent.update(__MODULE__, fn state -> %{state | ready: true} end)

  def set_unready(), do: Agent.update(__MODULE__, fn state -> %{state | ready: false} end)

  def set_alive(), do: Agent.update(__MODULE__, fn state -> %{state | live: true} end)

  def set_dead(), do: Agent.update(__MODULE__, fn state -> %{state | live: false} end)
end