defmodule Podium.Action do
  @moduledoc """
  Represents an Action in the Podium API.
  """

  @type t :: %__MODULE__{
          conversation_uid: String.t(),
          interaction_uid: String.t(),
          label: String.t(),
          uri: String.t()
        }

  @derive Jason.Encoder
  defstruct conversation_uid: nil,
            interaction_uid: nil,
            label: nil,
            uri: nil
end
