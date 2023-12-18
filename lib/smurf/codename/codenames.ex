defmodule Smurf.Codenames do
  use Ash.Api,
    extensions: [AshAdmin.Api]

  admin do
    show? true
  end

  resources do
    registry Smurf.Codenames.Registry
  end
end
