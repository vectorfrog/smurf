defmodule SmurfTui.Panels.Editor do
  import Ratatouille.View
  import Ratatouille.Constants, only: [key: 1]

  @spacebar key(:space)
  @enter key(:enter)
  @escape key(:esc)
  @left key(:arrow_left)
  @right key(:arrow_right)
  @delete_keys [
    key(:delete),
    key(:backspace),
    key(:backspace2)
  ]

  def model,
    do: %{
      str: "",
      index: 0,
      show: false,
      action: nil
    }

  # returns {handle_atom, editor_state}
  def update(editor, msg) do
    case {editor, msg} do
      {_, {:event, %{key: @escape}}} ->
        {:ok, model()}

      {editor, {:event, %{ch: c}}} when c > 0 ->
        {:ok, insert(editor, <<c::utf8>>)}

      {editor, {:event, %{key: @spacebar}}} ->
        {:ok, insert(editor, " ")}

      {editor, {:event, %{key: @enter}}} ->
        case editor.action do
          :add -> {:enter, editor}
          :update -> {:update, editor}
        end

      {editor, {:event, %{key: key}}}
      when key in @delete_keys ->
        {:ok, backspace(editor)}

      {editor, {:event, %{key: @left}}} ->
        {:ok, Map.put(editor, :index, max(editor.index - 1, 0))}

      {editor, {:event, %{key: @right}}} ->
        {:ok, Map.put(editor, :index, min(editor.index + 1, String.length(editor.str)))}
    end
  end

  def render(editor, title) do
    panel(title: title, color: :green) do
      label do
        text(content: String.slice(editor.str, 0, editor.index))
        text(content: "|", color: :green)
        text(content: String.slice(editor.str, editor.index, String.length(editor.str)))
      end
    end
  end

  def insert(str, index, char) do
    str |> String.graphemes() |> List.insert_at(index, char) |> Enum.join()
  end

  def insert(editor, char) do
    editor
    |> Map.put(
      :str,
      editor.str |> String.graphemes() |> List.insert_at(editor.index, char) |> Enum.join()
    )
    |> Map.put(:index, editor.index + 1)
  end

  def backspace(editor) do
    if editor.index > 0 do
      editor
      |> Map.put(
        :str,
        editor.str |> String.graphemes() |> List.delete_at(editor.index - 1) |> Enum.join()
      )
      |> Map.put(:index, max(editor.index - 1, 0))
    else
      editor
    end
  end
end
