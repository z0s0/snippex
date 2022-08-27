defmodule Snippex.Core.SnippetSchema do
  use Ecto.Schema

  import Ecto.Changeset

  schema "snippets" do
    field :lang, Snippex.Core.Schema.Types.Atom
    field :code, :string
    field :deps, :map, default: %{}
    field :lang_version, :string
    field :otp_version, :string

    timestamps()
  end

  def changeset(snippet, params) do
    snippet
    |> cast(params, [:code, :lang, :deps, :lang_version, :otp_version])
    |> validate_required([:code, :lang, :lang_version, :otp_version])
  end
end