defmodule SmurfTui.Panels.CodeNames do
  import Ratatouille.View
  import SmurfTui.Panels.Helpers

  def codenames(model) do
    row do
      column(size: 2) do
        panel([title: "Codenames"] ++ title_style(:codenames, model.active_panel)) do
          table do
            for i <- model.topic.codenames do
              table_row do
                table_cell(content: i.name)
              end
            end
          end
        end
      end
    end
  end
end
