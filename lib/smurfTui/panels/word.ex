defmodule SmurfTui.Panels.Word do
  import Ratatouille.View
  import SmurfTui.Panels.Helpers

  def update_word(model, msg) do
    model
  end

  def word(model) do
    row do
      column(size: 5) do
      end

      column(size: 2) do
        panel([title: "CodeName"] ++ title_style(:word, model.active_panel)) do
          label([content: model.word] ++ bg_style(:word, model.active_panel))
        end
      end

      column(size: 5) do
      end
    end
  end
end
