defmodule Podium.API do
  @moduledoc """
    Provides a basic HTTP interface to allow easy communication with the Podium
    API, by wrapping `HTTPoison`.
  """

  @default_base_url "https://api.podium.com/api/v2"

  use HTTPoison.Base

  @spec process_url(String.t()) :: String.t()
  def process_url(path) do
    base_url() <> path
  end

  @spec process_request_headers(list()) :: list()
  def process_request_headers(headers) do
    [
      {"Accept", "application/json"},
      {"Authorization", api_key()},
      {"Content-Type", "application/json"}
    ] ++ headers
  end

  @spec process_request_body(map()) :: String.t()
  def process_request_body(body) do
    Jason.encode!(body)
  end

  @spec api_key() :: String.t()
  defp api_key, do: Application.get_env(:podium, :api_key, "")

  @spec base_url() :: String.t()
  defp base_url, do: Application.get_env(:podium, :base_url, @default_base_url)

  @spec application_uid() :: String.t()
  defp application_uid, do: Application.get_env(:podium, :application_uid, "")
end
