defmodule Podium.Message do
  @moduledoc """
  Represents a message in the Podium API.
  """

  alias Podium.Contact

  @type t :: %__MODULE__{
          body: String.t(),
          contact: Contact.t(),
          conversation_uid: String.t(),
          location_uid: String.t()
        }

  @derive Jason.Encoder
  defstruct body: nil,
            contact: nil,
            conversation_uid: nil,
            location_uid: nil
end
