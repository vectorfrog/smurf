defmodule SmurfTui.Panels.Helpers do
  import Ratatouille.View
  def bg_style(x, x), do: [background: :green]
  def bg_style(_, _), do: [background: :default]
  def title_style(x, x), do: [color: :green]
  def title_style(_, _), do: [color: :default]

  def topbar(model) do
    bar do
      label(background: :white, content: print_key(model.key))
    end
  end

  def print_key(%{type: t, mod: m, key: k, ch: c}) do
    ~s(type: #{t} mod: #{m} key: #{k} ch: #{c})
  end

  def print_key(%{}), do: ~s(type: nil mod: nil key: nil ch: nil)

  def change_index(_list, nil, _move), do: 0

  def change_index(list, index, move) do
    l = length(list)

    if index + move < 0 do
      l - 1
    else
      rem(index + move, l)
    end
  end
end
