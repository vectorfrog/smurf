import Config

config :smurf, ecto_repos: [Smurf.Repo]
config :smurf, Smurf.Repo, database: "smurf_#{Mix.env()}.db"
