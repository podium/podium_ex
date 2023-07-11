defmodule Podium do
  @moduledoc """
  Podium is a client for Podium's public API. It allows you to create new
  messages and send them, among other things.

  All functions accept a keyword list of options as an optional second
  argument. Those options will be passed through to `HTTPoison.Request`. Other
  options include the following:

  - `:headers` - allows you to add headers to the defaults sent by the library
  """

  alias Podium.{
    API,
    ConversationItem,
    Interaction,
    Location,
    Message,
    Organization,
    Source
  }

  require Logger

  @doc """
  Create a conversation item. Read about conversation items [here](https://hexdocs.pm/podium_ex/Podium.ConversationItem.html#content).
  """
  @spec create_conversation_item(ConversationItem.t(), Keyword.t()) :: ConversationItem.t()
  def create_conversation_item(%ConversationItem{} = item, opts \\ []) do
    {headers, opts} = Keyword.pop(opts, :headers, [])

    conversation_item =
      item
      |> remove_nils()
      |> format_actions()
      |> inject_application_uid()
      |> inject_source_type()

    body =
      Caramelize.camelize(%{
        conversation_item: conversation_item
      })

    API.post("/conversation_items", body, headers, opts)
  end

  @doc """
  Update a [conversation item](https://hexdocs.pm/podium_ex/Podium.ConversationItem.html#content).
  """
  @spec update_conversation_item(ConversationItem.t(), Keyword.t()) :: ConversationItem.t()
  def update_conversation_item(%ConversationItem{} = item, opts \\ []) do
    {headers, opts} = Keyword.pop(opts, :headers, [])

    conversation_item =
      item
      |> remove_nils()
      |> inject_application_uid()
      |> inject_source_type()

    body =
      Caramelize.camelize(%{
        conversation_item: conversation_item
      })

    API.put("/conversation_items", body, headers, opts)
  end

  @doc """
  Delete a [conversation item](https://hexdocs.pm/podium_ex/Podium.ConversationItem.html#content).
  """
  @spec delete_conversation_item(String.t(), String.t(), Keyword.t()) :: :ok
  def delete_conversation_item(uid, org_uid, opts \\ []) do
    {headers, opts} = Keyword.pop(opts, :headers, [])
    application_uid = Application.get_env(:podium_ex, :application_uid)

    path = "/applications/#{application_uid}/organizations/#{org_uid}/conversation_items/#{uid}"

    API.delete(path, headers, opts)
  end

  @doc """
  Create a message. Read about messages [here](https://hexdocs.pm/podium_ex/Podium.Message.html#content).
  """
  @spec create_message(Message.t(), Keyword.t()) :: Message.t()
  def create_message(%Message{} = msg, opts \\ []) do
    {headers, opts} = Keyword.pop(opts, :headers, [])

    message =
      msg
      |> remove_nils()
      |> inject_application_uid()

    body =
      Caramelize.camelize(%{
        conversation_item: message
      })

    API.post("/messages", body, headers, opts)
  end

  @doc """
  Create an interaction. Read about interactions [here](https://hexdocs.pm/podium_ex/Podium.Interaction.html#content).
  """
  @spec create_interaction(Interaction.t(), Keyword.t()) :: Interaction.t()
  def create_interaction(%Interaction{} = interaction, opts \\ []) do
    {headers, opts} = Keyword.pop(opts, :headers, [])

    interaction =
      interaction
      |> remove_nils()
      |> inject_application_uid()
      |> inject_source_type()

    body =
      Caramelize.camelize(%{
        interaction: interaction
      })

    API.post("/interactions", body, headers, opts)
  end

  @doc """
  Update an [interaction](https://hexdocs.pm/podium_ex/Podium.Interaction.html#content).
  """
  @spec update_interaction(Interaction.t(), Keyword.t()) :: Interaction.t()
  def update_interaction(%Interaction{uid: uid} = interaction, opts \\ []) do
    {headers, opts} = Keyword.pop(opts, :headers, [])

    interaction =
      interaction
      |> remove_nils()
      |> inject_application_uid()
      |> inject_source_type()

    body =
      Caramelize.camelize(%{
        interaction: interaction
      })

    API.put("/interactions/#{uid}", body, headers, opts)
  end

  @doc """
  Get an organization and its locations.
  """
  @spec get_organization(String.t(), Keyword.t()) :: Organization.t() | nil
  def get_organization(uid, opts \\ []) do
    {headers, opts} = Keyword.pop(opts, :headers, [])

    with {:ok, %HTTPoison.Response{body: body, status_code: 200}} <-
           API.get("/organizations/#{uid}", headers, opts),
         {:ok, %{"data" => %{"organization" => org}}} <- Jason.decode(body),
         %{"uid" => uid, "locations" => locations, "businessName" => name} <- org do
      %Organization{
        business_name: name,
        locations: parse_locations(locations),
        uid: uid
      }
    else
      error ->
        Logger.error("Error while getting organization details from Podium: #{inspect(error)}")
        nil
    end
  end

  @spec parse_locations(list(map())) :: list(Location.t())
  defp parse_locations(locations) do
    Enum.map(locations, fn location ->
      %Location{
        address: location["address"],
        name: location["name"],
        uid: location["uid"]
      }
    end)
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
  defp format_actions(%{actions: actions} = struct)
       when is_list(actions) and length(actions) > 0 do
    formatted = Enum.map(actions, &remove_nils/1)
    Map.put(struct, :actions, formatted)
  end

  defp format_actions(struct), do: struct
end
