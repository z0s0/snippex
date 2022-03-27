defmodule Snippex.Core.ValidateCode do
  alias Snippex.Core.SnippetSpec

  """
  defmodule A do
    def plus(a, b), do
  end
"""
  def validate(%SnippetSpec{lang: :elixir, content: code}) do
    try do
      Code.compile_string(code)
      :ok
    rescue
      e -> {:error, e}
    end
  end
end