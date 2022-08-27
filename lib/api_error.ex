defmodule ApiError do
  use TypedStruct

  @derive Jason.Encoder
  typedstruct do
    field :errors, [String.t()]
  end

  def of(err) when is_binary(err), do: %__MODULE__{errors: [err]}
  def of(errors) when is_list(errors), do: %__MODULE__{errors: errors}
end