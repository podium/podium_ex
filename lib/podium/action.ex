defmodule Podium.Action do
  @moduledoc """
  Represents an Action in the Podium API.
  """

  @type t :: %__MODULE__{
    label: String.t(),
    interaction_uid: String.t(),
    conversation_uid: String.t()
  }

  @derive Jason.Encoder
  defstruct [
    label: nil,
    interaction_uid: nil,
    conversation_uid: nil
  ]
end
