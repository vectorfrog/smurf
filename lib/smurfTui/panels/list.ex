defmodule SmurfTui.Panels.List do
  import Ratatouille.View
  import Ratatouille.Constants, only: [key: 1]

  @up key(:arrow_up)
  @down key(:arrow_down)
  @left key(:arrow_left)
  @right key(:arrow_right)

  def model(list, keyword_list \\ []) do
    {width, str} = {set_key(keyword_list, :width, 1), set_key(keyword_list, :str, :name)}

    clist =
      case rem(length(list), width) do
        0 ->
          list |> Enum.chunk_every(width)

        val ->
          tmp_list = list |> Enum.chunk_every(width)

          tmp_list
          |> List.replace_at(-1, List.last(tmp_list) ++ List.duplicate(%{name: ""}, width - val))
      end

    %{
      items: clist,
      width: width,
      height: length(clist),
      str: str,
      v_index: nil,
      h_index: nil
    }
  end

  def set_key(list, key, default) do
    case Keyword.fetch(list, key) do
      :error -> default
      {:ok, val} -> val
    end
  end

  def update(list, msg) do
    case msg do
      %{ch: ?j} ->
        {:move, list |> change_v_index(1) |> change_h_index(0)}

      %{key: @down} ->
        {:move, list |> change_v_index(1) |> change_h_index(0)}

      %{ch: ?k} ->
        {:move, list |> change_v_index(-1) |> change_h_index(0)}

      %{key: @up} ->
        {:move, list |> change_v_index(-1) |> change_h_index(0)}

      %{ch: ?l} ->
        {:move, list |> change_v_index(0) |> change_h_index(1)}

      %{key: @right} ->
        {:move, list |> change_v_index(0) |> change_h_index(1)}

      %{ch: ?h} ->
        {:move, list |> change_v_index(0) |> change_h_index(-1)}

      %{key: @left} ->
        {:move, list |> change_v_index(0) |> change_h_index(-1)}
    end
  end

  def render(list) do
    table do
      for {t_row, vi} <- Enum.with_index(list.items) do
        table_row do
          for {item, hi} <- Enum.with_index(t_row) do
            table_cell(
              content: item.name,
              background: highlighter(vi, list.v_index, hi, list.h_index)
            )
          end
        end
      end
    end
  end

  def highlighter(x, x, y, y), do: :green
  def highlighter(_, _, _, _), do: :default

  def change_v_index(%{v_index: nil} = list, 0) do
    list |> put_in([:v_index], 0)
  end

  def change_v_index(%{v_index: nil} = list, 1) do
    list |> put_in([:v_index], 0)
  end

  def change_v_index(%{v_index: nil} = list, -1) do
    list |> put_in([:v_index], list.height - 1)
  end

  def change_v_index(list, move) do
    if list.v_index + move < 0 do
      put_in(list, [:v_index], list.height - 1)
    else
      put_in(list, [:v_index], rem(list.v_index + move, list.height))
    end
  end

  def change_h_index(%{h_index: nil} = list, 0) do
    list |> put_in([:h_index], 0)
  end

  def change_h_index(%{h_index: nil} = list, 1) do
    list |> put_in([:h_index], 0)
  end

  def change_h_index(%{h_index: nil} = list, -1) do
    list |> put_in([:h_index], list.width - 1)
  end

  def change_h_index(list, move) do
    if list.h_index + move < 0 do
      put_in(list, [:h_index], list.width - 1)
    else
      put_in(list, [:h_index], rem(list.h_index + move, list.width))
    end
  end

  def get_cell(chunked_list, v_index, h_index),
    do: Enum.at(Enum.at(chunked_list, v_index), h_index)
end
