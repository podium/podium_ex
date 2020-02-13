defmodule Podium.API do
  @moduledoc """
    Provides a basic HTTP interface to allow easy communication with the Podium
    API, by wrapping `HTTPoison`.
  """

  @default_base_url "https://api.podium.com/api/v2"

  use HTTPoison.Base

  @impl HTTPoison.Base
  def process_url(path) do
    base_url() <> path
  end

  @impl HTTPoison.Base
  def process_request_headers(headers) do
    [
      {"Accept", "application/json"},
      {"Authorization", api_key()},
      {"Content-Type", "application/json"},
      {"Application-Uid", application_uid()}
    ] ++ headers
  end

  @impl HTTPoison.Base
  def process_request_body(body) do
    Jason.encode!(body)
  end

  @impl HTTPoison.Base
  def process_request_options(opts) do
    opts ++ [timeout: timeout(), recv_timeout: recv_timeout()]
  end

  @spec api_key() :: String.t()
  defp api_key, do: Application.get_env(:podium_ex, :api_key, "")

  @spec base_url() :: String.t()
  defp base_url, do: Application.get_env(:podium_ex, :base_url, @default_base_url)

  @spec timeout :: integer()
  defp timeout, do: Application.get_env(:podium_ex, :timeout, 15_000)

  @spec recv_timeout :: integer()
  defp recv_timeout, do: Application.get_env(:podium_ex, :recv_timeout, 15_000)

  @spec application_uid() :: String.t()
  defp application_uid, do: Application.get_env(:podium_ex, :application_uid, "")
end
