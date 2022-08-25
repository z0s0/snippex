defmodule Snippex.Core.SnippetSpec do
  use TypedStruct

  typedstruct do
    field :lang, :erlang | :elixir, default: :elixir
    field :content, String.t()
    field :deps, [{atom, String.t()}], default: []
  end

  def of(%{content: code, lang: lang}), do: %__MODULE__{
    content: code,
    lang: lang
  }

  @spec of(Map.t()) :: {:error, String.t()} | {:ok, Snippex.Core.SnippetSpec.t()}
  def of(%{"code" => code, "lang" => lang}) do

  end

  def of(_), do: :wrong_params
end
