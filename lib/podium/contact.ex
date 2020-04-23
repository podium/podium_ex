defmodule Podium.Contact do
  @moduledoc """
  Represents a contact in the Podium API.
  """

  @type t :: %__MODULE__{
    email: String.t(),
    name: String.t(),
    phone_number: String.t()
  }

  @derive Jason.Encoder
  defstruct [
    email: nil,
    name: nil,
    phone_number: nil
  ]
end
