defmodule Podium do
  @moduledoc """
  An HTTP client for the Podium API.
  """

  alias Podium.{
    ConversationItem,
    Interaction,
    Message
  }

  @doc """
  Create a conversation item.
  """
  @spec create_conversation_item(ConversationItem.t()) :: ConversationItem.t()
  def create_conversation_item(item) do
    item
  end

  @doc """
  Update a conversation item.
  """
  @spec update_conversation_item(ConversationItem.t()) :: ConversationItem.t()
  def update_conversation_item(item) do
    item
  end

  @doc """
  Delete a conversation item.
  """
  @spec delete_conversation_item(String.t()) :: :ok
  def delete_conversation_item(_uid) do
    :ok
  end

  @doc """
  Create a message.
  """
  @spec create_message(Message.t()) :: Message.t()
  def create_message(message) do
    message
  end

  @doc """
  Create an interaction.
  """
  @spec create_interaction(Interaction.t()) :: Interaction.t()
  def create_interaction(interaction) do
    interaction
  end

  @doc """
  Update an interaction.
  """
  @spec update_interaction(Interaction.t()) :: Interaction.t()
  def update_interaction(interaction) do
    interaction
  end
end
