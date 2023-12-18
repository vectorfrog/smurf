defmodule Smurf.Repo do
  use AshPostgres.Repo,
    otp_app: :smurf

  def installed_extensions() do
    ["uuid-ossp", "citext"]
  end
end
