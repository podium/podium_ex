defmodule Podium.Contact do
  @moduledoc """
  Represents a contact in the Podium API.
  """

  @type t :: %__MODULE__{
          name: String.t(),
          email: String.t(),
          phone_number: String.t()
        }

  @derive Jason.Encoder
  defstruct name: nil,
            email: nil,
            phone_number: nil
end
