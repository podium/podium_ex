defmodule PodiumEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :podium_ex,
      description: "HTTP client for interfacing with the Podium API",
      version: "0.6.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/podium/podium_ex",
      homepage_url: "https://podium.com",
      package: package(),
      name: "Podium",
      docs: [
        main: Podium
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:caramelize, "~> 0.2"},
      {:httpoison, "~> 1.4"},
      {:jason, "~> 1.1"}
    ]
  end

  defp package do
    [
      maintainers: ["Dennis Beatty"],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/podium/podium_ex"
      }
    ]
  end
end
