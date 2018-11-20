# PodiumEx

A library for interfacing with the Podium API. Documentation can be found on [HexDocs](https://hexdocs.pm/podium_ex).

## Installation

The package can be installed by adding `podium_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:podium_ex, "~> 0.2"}
  ]
end
```

Then run `mix deps.get` to download it.

## Configuration

You will need to provide the following configuration options (usually in `config/config.exs`). It is recommended to use environment variables in production to avoid committing secrets in your repository. However, environment variables will cause problems if you are generating releases with distillery or exrm. Configuration should include:

  `:api_key` - The API key given to you by Podium.
  `:application_uid` - The ID given to you by Podium.

You can optionally also include the following:

  `:base_url` - The root URL onto which all paths are appended. Defaults to `https://api.podium.com/api/v2/`

### Example Configuration

```elixir
config :podium,
  api_key: "podiumisthebestever",
  application_uid: "abc098-1234abc-1234abcdefgh"
```
