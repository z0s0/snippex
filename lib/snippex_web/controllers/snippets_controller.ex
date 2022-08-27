defmodule SnippexWeb.SnippetsController do
  use SnippexWeb, :controller

  alias Snippex.Core.SnippetContext

  def create(conn, params) do
    case validate_create_params(params) do
      :ok ->
        snippet = Snippex.Core.Snippet.of(Map.put(params, "lang", String.to_atom(String.downcase(params["lang"]))))

        if !logged_in?(conn) && snippet.deps.length > 0 do
          send_json(conn, 400, ApiError.of("Only logged in users can add dependencies"))
        else
          case Snippex.Core.BuildSpec.build(snippet) do
            :ok -> send_json(conn, 201, snippet)
            {:error, e} -> send_json(conn, 400, ApiError.of(e))
          end
        end

      {:error, e} -> send_json(conn, 400, e)
    end
  end

  def get(conn, params) do
     case SnippetContext.by_id_or_shortcut(params["id"]) do
       nil -> send_json(conn, 404, ApiError.of("Snippet with identifier #{params["id"]} not found"))
       snippet -> send_json(conn, 200, snippet)
     end
  end

  defp logged_in?(conn), do: true

  defp validate_create_params(%{"code" => _, "lang" => _} = params) do
    params
    |> Enum.reduce([], fn
      {"lang", lang}, acc ->
        if lang == "Elixir" || lang == "Erlang" do
          acc
        else
          ["Code is Empty" | acc]
        end

      {"code", code}, acc ->
        if code != nil && code != "" do
          acc
        else
          ["Code must not be blank" | acc]
        end

      _, acc -> acc
    end)
    |> Enum.map(fn err -> {:error, err} end)
    |> case do
         [] -> :ok
         errors -> errors
       end
  end

  defp validate_create_params(_), do: {:error, "Missing field"}
end