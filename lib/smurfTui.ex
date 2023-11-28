defmodule SmurfTui do
  @behaviour Ratatouille.App

  import Ratatouille.View
  alias SmurfTui.Panels
  alias SmurfTui.Panels.Topic
  alias SmurfTui.Panels.CodeNames

  # color reference > :black, :blue, :cyan, :default, :green, :magenta, :red, :white, :yellow
  @panels [:word, :topics, :codenames]

  @impl true
  def init(model) do
    model
    |> Map.put(:topics, SmurfTui.Panels.Topic.model())
    |> Map.put(:codenames, SmurfTui.Panels.CodeNames.model(%{codenames: []}))
    |> Map.put(:word, SmurfTui.Panels.Word.model())
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

      {%{active_panel: :word}, msg} ->
        Panels.update_word(model, msg)

      {%{active_panel: :topics}, msg} ->
        Panels.update_topics(model, msg)

      {%{active_panel: :codenames}, msg} ->
        Panels.update_codenames(model, msg)

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
    view(top_bar: Panels.topbar(model), bottom_bar: Panels.bottombar(model)) do
      Panels.word(model)

      row do
        Topic.render(model)
        CodeNames.render(model)
      end
    end
  end
end
