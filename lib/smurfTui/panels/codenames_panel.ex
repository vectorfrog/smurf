defmodule SmurfTui.Panels.CodeNames do
  import Ratatouille.View
  import SmurfTui.Panels.Helpers
  import Ratatouille.Constants, only: [key: 1]

  @spacebar key(:space)
  @escape key(:esc)
  @enter key(:enter)

  def update_codenames(model, msg) do
    case {model, msg} do
      {%{codename_panel: %{add_codename: false}}, {:event, %{ch: ?a}}} ->
        %{model | codename_panel: %{model.codename_panel | add_codename: true}}

      {%{codename_panel: %{add_codename: true}}, {:event, %{key: 27}}} ->
        # escape
        %{model | codename_panel: %{model.codename_panel | add_codename: false}}

      {%{codename_panel: %{add_codename: true}}, {:event, %{ch: c}}} when c > 0 ->
        # typing a new topic name
        %{
          model
          | codename_panel: %{model.codename_panel | new: model.codename_panel.new <> <<c::utf8>>}
        }

      {%{codename_panel: %{add_codename: true}}, {:event, %{key: @spacebar}}} ->
        %{model | codename_panel: %{model.codename_panel | new: model.codename_panel.new <> " "}}

      {%{codename_panel: %{add_codename: true}}, {:event, %{key: @enter}}} ->
        Smurf.add_codename(model.codename_panel.new, model.topics_panel.active)

        %{
          model
          | topics_panel: %{
              model.topics_panel
              | topics: Smurf.all_topics(),
                active: Smurf.get_topic(model.topics_panel.active)
            },
            codename_panel: %{model.codename_panel | add_codename: false, new: ""}
        }

      {%{codename_panel: %{add_codename: false}}, {:event, %{ch: ?j}}} ->
        set_codename(model, 1)

      {%{codename_panel: %{add_codename: false}}, {:event, %{ch: ?k}}} ->
        set_codename(model, -1)

      {_, {:event, map}} ->
        %{model | key: map}
    end
  end

  def codenames(%{codename_panel: panel} = model) do
    column(size: 10) do
      panel([title: "Codenames"] ++ title_style(:codenames, model.active_panel)) do
        if panel.add_codename do
          if model.topics_panel.active.id != nil do
            panel([title: "Add CodeName"] ++ title_style(:topics, model.active_panel)) do
              label(content: panel.new)
            end
          else
            label(content: "Please select a topic before adding codenames")
          end
        end

        if model.topics_panel.active.codenames == [] do
          label(content: "No codenames")
        else
          table do
            for i <- model.topics_panel.active.codenames do
              table_row do
                table_cell(content: i.name)
              end
            end
          end
        end
      end
    end
  end

  defp set_codename(model, move) do
    new_index =
      change_index(model.topics_panel.active.codenames, model.codename_panel.index, move)

    %{
      model
      | codename_panel: %{
          model.codename_panel
          | index: new_index,
            active: Enum.at(model.topics_panel.active.codenames, new_index)
        }
    }
  end
end
