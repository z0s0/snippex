defmodule Snippex.Core.BuildImage do
  alias Snippex.Core.SnippetSpec

  @spec from_spec(SnippetSpec.t()) :: {:ok, nil} | {:error, String.t()}
  def from_spec(%SnippetSpec{}) do

  end
end