defmodule SmurfTui.Panels.CodeNames do
  import Ratatouille.View
  import SmurfTui.Panels.Helpers
  import Ratatouille.Constants, only: [key: 1]
  alias SmurfTui.Panels.Editor
  alias SmurfTui.Panels.List

  @spacebar key(:space)
  @escape key(:esc)
  @enter key(:enter)
  @move_chars [?j, ?k, ?h, ?l]
  @move_keys [key(:arrow_up), key(:arrow_down), key(:arrow_left), key(:arrow_right)]

  def model(active_topic),
    do: %{
      active: %Smurf.CodeName{},
      editor: Editor.model(),
      list: List.model(active_topic.codenames, width: 10)
    }

  def update_codenames(model, msg) do
    case {model, msg} do
      {%{codenames: %{editor: %{show: true}}}, msg} ->
        case Editor.update(model.codenames.editor, msg) do
          {:ok, new_editor} ->
            model |> put_in([:codenames, :editor], new_editor)

          {:enter, new_editor} ->
            cn = Smurf.add_codename(new_editor.str, model.topics.active)

            model
            |> put_in([:codenames, :editor], Editor.model())
            |> put_in([:topics, :active], Smurf.get_topic(cn.topic))
            |> put_in([:codenames], model(Smurf.get_topic(cn.topic)))

          {:update, new_editor} ->
            {:ok, cn} = Smurf.update_codename(model.codenames.active, new_editor.str)

            model
            |> put_in([:codenames, :editor], Editor.model())
            |> put_in([:topics, :active], Smurf.get_topic(cn.topic))
            |> put_in([:codenames], model(Smurf.get_topic(cn.topic)))
        end

      # list actions
      {model, {:event, %{ch: ch, key: key} = msg}} when ch in @move_chars or key in @move_keys ->
        case List.update(model.codenames.list, msg) do
          {:move, new_list} ->
            model
            |> put_in([:codenames, :list], new_list)
            |> put_in(
              [:codenames, :active],
              List.get_cell(new_list.items, new_list.v_index, new_list.h_index)
            )
        end

      {model, {:event, %{ch: ?a}}} ->
        model
        |> put_in([:codenames, :editor, :show], true)
        |> put_in([:codenames, :editor, :action], :add)

      {model, {:event, %{ch: ?e}}} ->
        model
        |> put_in([:codenames, :editor, :show], true)
        |> put_in([:codenames, :editor, :action], :update)
        |> put_in([:codenames, :editor, :str], model.codenames.active.name)

      {model, {:event, %{ch: ?d}}} ->
        Smurf.delete_codename(model.codenames.active)

        model
        |> put_in([:codenames], model(Smurf.get_topic(model.topics.active)))

      {model, {:event, %{key: @escape}}} ->
        model
        |> put_in([:codenames, :list, :v_index], nil)
        |> put_in([:codenames, :list, :h_index], nil)

      {model, {:event, %{key: @spacebar}}} ->
        model
        |> put_in([:word], Enum.random(model.topics.active.codenames) |> Map.get(:name))

      {_, {:event, map}} ->
        %{model | key: map}
    end
  end

  def render(%{codenames: panel} = model) do
    column(size: 10) do
      panel(
        [title: model.topics.active.name || "CodeNames"] ++
          title_style(:codenames, model.active_panel)
      ) do
        if panel.editor.show do
          if model.topics.active.id != nil do
            SmurfTui.Panels.Editor.render(panel.editor, "Add CodeName")
          else
            label(content: "Please select a topic before adding codenames")
          end
        end

        if model.topics.active.codenames == [] do
          label(content: "No codenames")
        else
          table do
          end

          SmurfTui.Panels.List.render(panel.list)
        end
      end
    end
  end
end
