defmodule Podium.Source do
  @moduledoc """
  Represents a source in the Podium API.
  """

  @type t :: :event | :inbound | :outbound

  @sources %{
    event: "EVENT",
    inbound: "INBOUND",
    outbound: "OUTBOUND"
  }

  def to_string(source) do
    @sources[source]
  end
end
