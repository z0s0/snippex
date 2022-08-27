defmodule Snippex.Core.BuildImage do
  alias Snippex.Core.Snippet

  @spec from_spec(Snippet.t()) :: {:ok, nil} | {:error, String.t()}
  def from_spec(%Snippet{} =  spec) do
    :ok
  end
end