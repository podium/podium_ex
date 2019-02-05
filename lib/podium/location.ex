defmodule Podium.Location do
  @moduledoc """
  Represents a location in the Podium API.
  """

  @type t :: %__MODULE__{
          name: String.t(),
          address: String.t(),
          uid: String.t()
        }

  @derive Jason.Encoder
  defstruct name: nil,
            address: nil,
            uid: nil
end
