defmodule Podium do
  @moduledoc """
  An HTTP client for the Podium API.
  """

  alias Podium.{
    API,
    ConversationItem,
    Interaction,
    Message
  }

  @doc """
  Create a conversation item.
  """
  @spec create_conversation_item(ConversationItem.t()) :: ConversationItem.t()
  def create_conversation_item(%ConversationItem{} = item) do
    conversation_item = %{
      conversation_item: inject_application_uid(item)
    }

    API.post("/conversation_items", conversation_item)
  end

  @doc """
  Update a conversation item.
  """
  @spec update_conversation_item(ConversationItem.t()) :: ConversationItem.t()
  def update_conversation_item(%ConversationItem{} = item) do
    conversation_item = %{
      conversation_item: inject_application_uid(item)
    }

    API.put("/conversation_items/#{item.uid}", conversation_item)
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
    message = %{
      message: inject_application_uid(msg)
    }

    API.post("/messages", message)
  end

  @doc """
  Create an interaction.
  """
  @spec create_interaction(Interaction.t()) :: Interaction.t()
  def create_interaction(%Interaction{} = int) do
    interaction = %{
      interaction: inject_application_uid(int)
    }

    API.post("/interactions", interaction)
  end

  @doc """
  Update an interaction.
  """
  @spec update_interaction(Interaction.t()) :: Interaction.t()
  def update_interaction(%Interaction{} = int) do
    interaction = %{
      interaction: inject_application_uid(int)
    }

    API.put("/interactions/#{interaction.uid}", interaction)
  end

  @spec inject_application_uid(map()) :: map()
  defp inject_application_uid(map) do
    application_uid = Application.get_env(:podium, :application_uid)

    map
    |> Map.from_struct()
    |> Map.put(:application_uid, application_uid)
  end
end
