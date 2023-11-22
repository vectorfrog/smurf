defmodule Smurf.MixProject do
  use Mix.Project

  def project do
    [
      app: :smurf,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Smurf.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sqlite3, "~> 0.12"},
      {:ratatouille, "~> 0.5.0"}
    ]
  end
end
