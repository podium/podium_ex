defmodule Podium.Organization do
  @moduledoc """
  Represents an organization in the Podium API.
  """

  alias Podium.Location

  @type t :: %__MODULE__{
          business_name: String.t(),
          uid: String.t(),
          locations: list(Location.t())
        }

  @derive Jason.Encoder
  defstruct business_name: nil,
            uid: nil,
            locations: nil
end
