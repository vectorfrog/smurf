defmodule SmurfTui.Panels.Topic do
  import Ratatouille.View
  import SmurfTui.Panels.Helpers
  import Ratatouille.Constants, only: [key: 1]

  @spacebar key(:space)
  @enter key(:enter)
  @escape key(:esc)

  def update_topics(model, msg) do
    case {model, msg} do
      {%{topics_panel: %{add_topic: false}}, {:event, %{ch: ?a}}} ->
        %{model | topics_panel: %{model.topics_panel | add_topic: true}}

      {%{topics_panel: %{add_topic: true}}, {:event, %{key: 27}}} ->
        # escape
        %{model | topics_panel: %{model.topics_panel | add_topic: false}}

      {%{topics_panel: %{add_topic: true}}, {:event, %{ch: c}}} when c > 0 ->
        # typing a new topic name
        %{
          model
          | topics_panel: %{model.topics_panel | new: model.topics_panel.new <> <<c::utf8>>}
        }

      {%{topics_panel: %{add_topic: true}}, {:event, %{key: @spacebar}}} ->
        %{model | topics_panel: %{model.topics_panel | new: model.topics_panel.new <> " "}}

      {%{topics_panel: %{add_topic: true}}, {:event, %{key: @enter}}} ->
        Smurf.add_topic(model.topics_panel.new)

        %{
          model
          | topics_pane: %{model.topics_panel | topics: Smurf.all_topics(), add_topic: false}
        }

      {%{topics_panel: %{add_topic: false}}, {:event, %{ch: ?j}}} ->
        set_topic(model, 1)

      {%{topics_panel: %{add_topic: false}}, {:event, %{ch: ?k}}} ->
        set_topic(model, -1)

      {%{topics_panel: %{add_topic: false}}, {:event, %{key: @escape}}} ->
        %{
          model
          | topics_panel: %{model.topics_panel | index: nil, active: %Smurf.Topic{codenames: []}}
        }

      {_, {:event, map}} ->
        %{model | key: map}
    end
  end

  def topic(%{topics_panel: panel} = model) do
    column(size: 2) do
      panel([title: "Topics"] ++ title_style(:topics, model.active_panel)) do
        if panel.add_topic do
          panel([title: "Add Topic"] ++ title_style(:topics, model.active_panel)) do
            label(content: panel.new)
          end
        end

        table do
          for {t, i} <- Enum.with_index(panel.topics) do
            table_row do
              table_cell(
                content: t.name,
                background: highligher(i, panel.index, model.active_panel)
              )
            end
          end
        end
      end
    end
  end

  defp highligher(x, x, :topics), do: :green
  defp highligher(x, x, _), do: :cyan
  defp highligher(_, _, _), do: :default

  defp set_topic(model, move) do
    new_index = change_index(model.topics_panel.topics, model.topics_panel.index, move)

    %{
      model
      | topics_panel: %{
          model.topics_panel
          | index: new_index,
            active: Enum.at(model.topics_panel.topics, new_index)
        }
    }
  end
end
