defmodule Smurf.CodeName do
  use Ecto.Schema
  import Ecto.Changeset

  schema "codenames" do
    field(:name, :string)
    belongs_to(:topic, Smurf.Topic)
    timestamps()
  end

  def changeset(code_name, params \\ %{}) do
    code_name
    |> cast(params, [:name])
    |> cast_assoc(:topic)
    |> validate_required([:name, :topic])
  end
end
