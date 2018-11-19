defmodule Podium.Contact do
  @moduledoc """
  Represents a contact in the Podium API.
  """

  @type t :: %__MODULE__{
    name: String.t(),
    phone_number: String.t()
  }

  defstruct [
    name: nil,
    phone_number: nil
  ]
end
