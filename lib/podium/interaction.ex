defmodule Podium.Interaction do
  @moduledoc """
  Represents an Interaction in the Podium API.
  """

  alias Podium.{
    Contact,
    Source
  }

  @type t :: %__MODULE__{
          contact: Contact.t(),
          header: String.t(),
          body: String.t(),
          location_uid: String.t(),
          icon_url: String.t(),
          source_type: Source.t(),
          publish_date: DateTime.t(),
          iframe_url: String.t(),
          uid: String.t()
        }

  @derive Jason.Encoder
  defstruct contact: nil,
            header: nil,
            body: nil,
            location_uid: nil,
            icon_url: nil,
            source_type: nil,
            publish_date: nil,
            iframe_url: nil,
            uid: nil
end
