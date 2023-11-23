defmodule SmurfTui do
  @behaviour Ratatouille.App

  import Ratatouille.View
  alias SmurfTui.Panels

  # color reference > :black, :blue, :cyan, :default, :green, :magenta, :red, :white, :yellow
  @panels [:word, :topics, :codenames]

  @impl true
  def init(model) do
    model
    |> Map.put(:topics, Smurf.all_topics())
    |> Map.put(:topic, %Smurf.Topic{codenames: []})
    |> Map.put(:word, Smurf.all_codenames() |> Enum.random() |> Map.get(:name))
    |> Map.put(:key, %{})
    |> Map.put(:active_panel, :word)
  end

  @impl true
  def update(model, msg) do
    case {model, msg} do
      {_, {:event, %{key: 9} = map}} ->
        tab_action(model, 1)
        |> Map.put(:key, map)

      {_, {:event, %{ch: 90} = map}} ->
        # shift-tab
        tab_action(model, -1)
        |> Map.put(:key, map)

      {_, {:event, map}} ->
        %{model | key: map}
    end
  end

  def tab_action(model, move) do
    {_val, index} =
      @panels
      |> Enum.with_index()
      |> Enum.find(@panels, fn {val, _} -> val == model.active_panel end)

    %{model | active_panel: Enum.at(@panels, rem(index + move, length(@panels)))}
  end

  @impl true
  def render(model) do
    view(top_bar: Panels.topbar(model)) do
      Panels.word(model)
      Panels.topic(model)
      Panels.codenames(model)
    end
  end
end
