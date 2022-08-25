defmodule SnippexWeb.SnippetsController do
  use SnippexWeb, :controller

  def create(conn, %{"code" => code} = params) do
    case validate_create_params(params) do
      :ok ->
        snippet = Snippex.Core.SnippetSpec.of(params)

        if !logged_in?(conn) && snippet.deps.length > 0 do
          send_resp(conn, 400, "Only logged in users can add dependencies")
        else
          Snippex.Core.BuildSpec.build(snippet)
          IO.inspect("Building snippet #{snippet}")

          send_resp(conn, 201, Jason.encode!(snippet))
        end

      {:error, e} -> send_resp(conn, 400, e)
    end
  end


  defp logged_in?(conn), do: true

  defp validate_create_params(params) do
    code = params["code"]

    if code == "Elixir" || code == "Erlang" do
      :ok
    else
      {:error, "Language must be either Elixir or Erlang"}
    end
  end
end