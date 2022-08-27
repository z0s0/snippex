defmodule Snippex.Core.Snippet do
  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :lang, :erlang | :elixir, default: :elixir
    field :code, String.t()
    field :deps, Map.t(), default: %{}
  end

  def of(%{code: code, lang: lang}), do: %__MODULE__{
    code: code,
    lang: lang
  }

  @spec of(Map.t()) :: {:error, String.t()} | {:ok, Snippex.Core.Snippet.t()}
  def of(%{"code" => code, "lang" => lang}), do:
    %__MODULE__{code: code, lang: lang}

  def of(_), do: :wrong_params
end
