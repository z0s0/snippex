defmodule Snippex.Core.ValidateCode do
  alias Snippex.Core.Snippet

  @wrapper_module :"SnippexWrapper"

  def validate(%Snippet{lang: :elixir, code: code}) do
     with :ok <- try_compile(:elixir, code),
          :ok <- unload(@wrapper_module) do
       :ok
     else
       {:error, %SyntaxError{column: col, description: desc}} ->
         {:error, "SyntaxError. column: #{col}, description: #{desc}"}

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
    :code.purge(module)
    :code.delete(module)
    :ok
  end
end