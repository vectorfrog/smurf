defmodule Smurf.Codenames.Calculations.Slug do
  use Ash.Calculation

  @impl true
  def select(_, _, _), do: [:name]

  @impl true
  def calculate(records, _, _) do
    Enum.map(records, fn record ->
      record.name |> Slug.slugify()
    end)
  end
end
