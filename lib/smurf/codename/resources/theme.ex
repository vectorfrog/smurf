defmodule Smurf.Codenames.Theme do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAdmin.Resource]

  require Ash.Query

  code_interface do
    define_for Smurf.Codenames
    define :create, args: [:name, :image]
    define :read
    define :update, action: :update
    define :destroy, action: :destroy
  end

  actions do
    defaults [:read, :update, :destroy]

    create :create do
      accept [:name, :image]
    end
  end

  calculations do
    calculate :slug, :string, Smurf.Codenames.Calculations.Slug
    calculate :count, :integer, expr(count(codenames))
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string
    attribute :image, :string
  end

  relationships do
    has_many :codenames, Smurf.Codenames.Codename
  end

  postgres do
    table "themes"
    repo Smurf.Repo
  end
end
