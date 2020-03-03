defmodule Podium.Organization do
  @moduledoc """
  Represents an organization in the Podium API.
  """

  alias Podium.Location

  @type t :: %__MODULE__{
          business_name: String.t(),
          csm_admin_name: String.t(),
          uid: String.t(),
          vertical_details: %{vertical_name: String.t(), sub_vertical_name: String.t()},
          locations: list(Location.t())
        }

  @derive Jason.Encoder
  defstruct business_name: nil,
            csm_admin_name: nil,
            uid: nil,
            vertical_details: %{vertical_name: nil, sub_vertical_name: nil},
            locations: nil
end
