defmodule Smurf.Repo do
  use Ecto.Repo, otp_app: :smurf, adapter: Ecto.Adapters.SQLite3
end
