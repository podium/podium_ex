defmodule Podium.Message do
  @moduledoc """
  Represents a message in the Podium API.
  """

  alias Podium.Contact

  @type t :: %__MODULE__{
    contact: Contact.t(),
    body: String.t(),
    location_uid: String.t()
  }

  defstruct contact: nil,
            body: nil,
            location_uid: nil
end
