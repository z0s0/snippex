defmodule Snippex.Core.BuildSpec do
  alias Snippex.Core.{
    Snippet,
    BuildImage,
    ValidateCode,
    SnippetContext
  }

  @spec build(Snippet.t()) :: :ok | {:error, String.t()}
  def build(%Snippet{} = spec) do
    with :ok <- ValidateCode.validate(spec),
         :ok <- BuildImage.from_spec(spec),
         _ <- SnippetContext.create_snippet(spec) do
      :ok
    else
      {:error, e} = err -> err
      _ -> {:error, "bad"}
    end
  end
end