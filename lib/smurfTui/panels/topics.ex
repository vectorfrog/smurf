defmodule SmurfTui.Panels.Topic do
  import Ratatouille.View
  import SmurfTui.Panels.Helpers
  import Ratatouille.Constants, only: [key: 1]
  alias SmurfTui.Panels.CodeNames
  alias SmurfTui.Panels.Word
  alias SmurfTui.Panels.Editor
  alias SmurfTui.Panels.List

  @spacebar key(:space)
  @escape key(:esc)
  @move_chars [?j, ?k, ?h, ?l]
  @move_keys [key(:arrow_up), key(:arrow_down), key(:arrow_left), key(:arrow_right)]

  def model,
    do: %{
      list: List.model(Smurf.all_topics()),
      active: %Smurf.Topic{codenames: []},
      editor: Editor.model()
    }

  def update_topics(model, msg) do
    case {model, msg} do
      # editor panel actions
      {%{topics: %{editor: %{show: true}}}, msg} ->
        case Editor.update(model.topics.editor, msg) do
          {:ok, new_editor} ->
            model |> put_in([:topics, :editor], new_editor)

          {:enter, new_editor} ->
            Smurf.add_topic(new_editor.str)

            model
            |> put_in([:topics, :editor], Editor.model())
            |> put_in([:topics, :list], List.model(Smurf.all_topics()))

          {:update, new_editor} ->
            Smurf.update_topic(model.topics.active, new_editor.str)

            model
            |> put_in([:topics, :editor], Editor.model())
            |> put_in([:topics, :list], List.model(Smurf.all_topics()))
        end

      # list actions
      {model, {:event, %{ch: ch, key: key} = msg}} when ch in @move_chars or key in @move_keys ->
        case List.update(model.topics.list, msg) do
          {:move, new_list} ->
            active = List.get_cell(new_list.items, new_list.v_index, new_list.h_index)

            model
            |> put_in([:topics, :list], new_list)
            |> put_in([:topics, :active], active)
            |> put_in([:codenames], CodeNames.model(active))
        end

      {_, {:event, %{ch: ?a}}} ->
        model
        |> put_in([:topics, :editor, :show], true)
        |> put_in([:topics, :editor, :action], :add)

      {_, {:event, %{ch: ?e}}} ->
        model
        |> put_in([:topics, :editor, :show], true)
        |> put_in([:topics, :editor, :str], model.topics.active.name)
        |> put_in([:topics, :editor, :action], :update)

      {_, {:event, %{ch: ?d}}} ->
        Smurf.delete_topic(model.topics.active)

        model
        |> put_in([:topics, :list], List.model(Smurf.all_topics()))
        |> put_in([:topics, :active], %Smurf.Topic{codenames: []})

      {_, {:event, %{key: @spacebar}}} ->
        %{model | word: Word.get_random(model.topics.active.codenames)}

      {_, {:event, %{key: @escape}}} ->
        %{
          model
          | topics: %{model.topics | index: nil, active: %Smurf.Topic{codenames: []}}
        }

      {_, {:event, map}} ->
        %{model | key: map}
    end
  end

  def render(%{topics: panel} = model) do
    column(size: 2) do
      panel([title: "Topics"] ++ title_style(:topics, model.active_panel)) do
        if panel.editor.show do
          SmurfTui.Panels.Editor.render(panel.editor, "Add Topic")
        end

        # for row <- panel.list.items, item <- row do
        #  label(content: item.name)
        # end
        SmurfTui.Panels.List.render(panel.list)
      end
    end
  end
end
