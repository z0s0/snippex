defmodule Snippex.Core.SnippetSpec do
  use TypedStruct

  typedstruct do
    field :lang, :erlang | :elixir, default: :elixir
    field :content, String.t()
    field :deps, [{atom, String.t()}], default: []
  end

  def of(%{content: code}), do: %__MODULE__{
    content: code
  }

  def of(_), do: :wrong_params
end
