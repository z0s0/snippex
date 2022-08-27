defmodule Snippex.Core.SnippetContext do
  @spec create_snippet(Snippex.Core.Snippet.t()) :: {:ok, String.t()} | {:error | Map.t()}

  alias Snippex.Repo
  alias Snippex.Core.{Snippet, SnippetSchema}

  def create_snippet(snippet) do
    params =
      snippet
      |> Map.from_struct()
      |> Map.put(:lang_version, "1.14")
      |> Map.put(:otp_version, "24")

    %SnippetSchema{}
    |> SnippetSchema.changeset(params)
    |> Repo.insert()
  end

  def by_id_or_shortcut(id_or_shortcut) do
    case Integer.parse(id_or_shortcut) do
      {id, ""} ->
        case Repo.get(SnippetSchema, id) do
          nil -> nil
          snippet -> Snippet.of(snippet)
        end

      _ -> nil
    end
  end
end