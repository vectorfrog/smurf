defmodule Smurf.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field(:name, :string)
    has_many(:codenames, Smurf.CodeName)
    timestamps()
  end

  def changeset(topic, params \\ %{}) do
    topic
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
