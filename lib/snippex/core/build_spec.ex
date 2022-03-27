defmodule Snippex.Core.BuildSpec do
  alias Snippex.Core.{
    SnippetSpec,
    BuildImage,
    ValidateCode
  }

  @spec build(SnippetSpec.t()) :: :ok | {:error, String.t()}
  def build(%SnippetSpec{} = spec) do
    with :ok <- ValidateCode.validate(spec),
         :ok <- BuildImage.from_spec(spec) do
      :ok
    else
      _ -> {:error, "bad"}
    end
  end
end