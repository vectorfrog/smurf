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

  def bottombar(model) do
    bar do
      case model.active_panel do
        :word ->
          label(background: :white, content: "<TAB>: Change Panels  |  <SPACE>: Random CodeName")

        :topics ->
          label(
            background: :white,
            content:
              "<TAB>: Change Panels  |  jk: select active topic  |  <SPACE>: Random CodeName in Topic | e: edit  | a: add  | d: delete | <ESC>: deselect"
          )

        :codenames ->
          label(
            background: :white,
            content:
              "<TAB>: Change Panels  |  jklh: select active codename  |  <SPACE>: Random CodeName in Topic | e: edit  | a: add  | d: delete | <ESC>: deselect"
          )
      end
    end
  end

  def print_key(%{type: t, mod: m, key: k, ch: c}) do
    ~s(type: #{t} mod: #{m} key: #{k} ch: #{c})
  end

  def print_key(%{}), do: ~s(type: nil mod: nil key: nil ch: nil)
end
