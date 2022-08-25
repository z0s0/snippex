defmodule Snippex.Core.ValidateCode do
  alias Snippex.Core.SnippetSpec

  @wrapper_module :"SnippexWrapper"

  def validate(%SnippetSpec{lang: :elixir, content: code}) do
     with :ok <- try_compile(:elixir, code),
          :ok <- unload(@wrapper_module) do
       :ok
     else
       {:error, message} = e -> e
       :not_found -> {:error, "Module not found"}
     end
  end

  @spec try_compile(atom(), String.t()) :: :ok | {:error, String.t()}
  defp try_compile(:elixir, code) do
    try do
      """
        defmodule #{@wrapper_module} do
          #{code}
        end
      """
      |> Code.compile_string()
      :ok
    rescue
      e -> {:error, e}
    end
  end

  defp unload(module) do
    if :code.delete(module) do
      :ok
    else
      :not_found
    end
  end
end