defmodule Smurf.Codenames.Registry do
  use Ash.Registry,
    extensions: [
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry Smurf.Codenames.Codename
    entry Smurf.Codenames.Theme
  end
end
