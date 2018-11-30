defmodule Podium do
  @moduledoc """
  An HTTP client for the Podium API.
  """

  alias Podium.{
    API,
    ConversationItem,
    Interaction,
    Message,
    Source
  }

  @doc """
  Create a conversation item.
  """
  @spec create_conversation_item(ConversationItem.t()) :: ConversationItem.t()
  def create_conversation_item(%ConversationItem{} = item) do
    conversation_item =
      item
      |> remove_nils()
      |> format_actions()
      |> inject_application_uid()
      |> inject_source_type()

    conversation_item = Caramelize.camelize(%{
      conversation_item: conversation_item
    })

    API.post("/conversation_items", Caramelize.camelize(conversation_item))
  end

  @doc """
  Update a conversation item.
  """
  @spec update_conversation_item(ConversationItem.t()) :: ConversationItem.t()
  def update_conversation_item(%ConversationItem{uid: uid} = item) do
    conversation_item =
      item
      |> remove_nils()
      |> inject_application_uid()
      |> inject_source_type()

    conversation_item = %{
      conversation_item: conversation_item
    }

    API.put("/conversation_items/#{uid}", Caramelize.camelize(conversation_item))
  end

  @doc """
  Delete a conversation item.
  """
  @spec delete_conversation_item(String.t()) :: :ok
  def delete_conversation_item(uid) do
    API.delete("/conversation_items/#{uid}")
  end

  @doc """
  Create a message.
  """
  @spec create_message(Message.t()) :: Message.t()
  def create_message(%Message{} = msg) do
    message =
      msg
      |> remove_nils()
      |> inject_application_uid()

    message = %{
      conversation_item: message
    }

    API.post("/messages", Caramelize.camelize(message))
  end

  @doc """
  Create an interaction.
  """
  @spec create_interaction(Interaction.t()) :: Interaction.t()
  def create_interaction(%Interaction{} = interaction) do
    interaction =
      interaction
      |> remove_nils()
      |> inject_application_uid()
      |> inject_source_type()

    interaction = %{
      interaction: interaction
    }

    API.post("/interactions", Caramelize.camelize(interaction))
  end

  @doc """
  Update an interaction.
  """
  @spec update_interaction(Interaction.t()) :: Interaction.t()
  def update_interaction(%Interaction{uid: uid} = interaction) do
    interaction =
      interaction
      |> remove_nils()
      |> inject_application_uid()
      |> inject_source_type()

    interaction = %{
      interaction: interaction
    }

    API.put("/interactions/#{uid}", Caramelize.camelize(interaction))
  end

  @spec remove_nils(map()) :: map()
  defp remove_nils(map) do
    map
    |> Map.from_struct()
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end

  @spec inject_application_uid(map()) :: map()
  defp inject_application_uid(map) do
    application_uid = Application.get_env(:podium_ex, :application_uid)
    Map.put(map, :application_uid, Caramelize.camelize(application_uid))
  end

  @spec inject_source_type(map()) :: map()
  defp inject_source_type(%{source_type: source} = struct) do
    Map.put(struct, :source_type, Source.to_string(source))
  end

  @spec format_actions(map()) :: map()
  def format_actions(%{actions: actions} = struct) when is_list(actions) and length(actions) > 0 do
    formatted = Enum.map(actions, &remove_nils/1)
    Map.put(struct, :actions, formatted)
  end

  def format_actions(struct), do: struct
end
