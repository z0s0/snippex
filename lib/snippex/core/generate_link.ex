defmodule Snippex.Core.GenerateLink do
  alias Snippex.Core.Snippet

  @spec from_spec(Snippet.t()) :: String.t()
  def from_spec(%Snippet{} = spec), do:
    "#{spec.lang}123"
end