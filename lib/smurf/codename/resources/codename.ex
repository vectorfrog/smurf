defmodule Smurf.Codenames.Codename do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAdmin.Resource]

  code_interface do
    define_for Smurf.Codenames
    define :create, action: :create
    define :read, action: :read
    define :update, action: :update
    define :destroy, action: :destroy
  end

  actions do
    create :with_topic do
      argument :theme_id, :uuid
      accept [:name, :rank, :image, :theme_id]
    end

    create :create do
      primary? true
    end

    read :read do
      primary? true
    end

    update :update do
      primary? true
    end

    destroy :destroy do
      primary? true
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string
    attribute :rank, :integer
    attribute :image, :string
  end

  relationships do
    belongs_to :theme, Smurf.Codenames.Theme do
      attribute_writable? true
    end
  end

  postgres do
    table "codenames"
    repo Smurf.Repo
  end
end
