defmodule Onfido.MixProject do
  use Mix.Project

  def project do
    [
      app: :onfido_v3,
      description: "Elixir wrapper for v3 of the Onfido API",
      package: package(),
      version: "0.1.5",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison_form_data, "~> 0.1"},
      {:httpoison, "~> 2.0"},
    ]
  end

  defp package do
    [
      name: "onfido_v3",
      maintainers: ["becky-pirate"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/becky-pirate/onfido"}
    ]
  end
end
