defmodule SnippexWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: SnippexWeb

      import Plug.Conn
      import SnippexWeb.ControllerHelpers

      alias SnippexWeb.Router.Helpers, as: Routes

      def send_json(conn, status, data), do:
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(status, Jason.encode!(data))
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/snippex_web/templates",
        namespace: SnippexWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  defp view_helpers do
    quote do
      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import SnippexWeb.ErrorHelpers
      alias SnippexWeb.Router.Helpers, as: Routes
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
