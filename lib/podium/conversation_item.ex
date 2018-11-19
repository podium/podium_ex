defmodule Podium.ConversationItem do
  @moduledoc """
  Represents a conversation item in the Podium API.
  """

  alias Podium.{
    Action,
    Contact,
    Source
  }

  @type t :: %__MODULE__{
    contact: Contact.t(),
    header: String.t(),
    subheader: String.t(),
    body: String.t(),
    location_uid: String.t(),
    icon_url: String.t(),
    actions: list(Action.t()),
    source_type: Source.t(),
    publish_date: DateTime.t(),
    uid: String.t()
  }

  defstruct [
    contact: nil,
    header: nil,
    subheader: nil,
    body: nil,
    location_uid: nil,
    icon_url: nil,
    actions: nil,
    source_type: nil,
    publish_date: nil,
    uid: nil
  ]
end
