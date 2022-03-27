defmodule Snippex.Core.GenerateLink do
  alias Snippex.Core.SnippetSpec

  @spec from_spec(SnippetSpec.t()) :: String.t()
  def from_spec(%SnippetSpec{} = spec), do:
    "#{spec.lang}123"
end