defmodule SmurfTui.Panels.Topic do
  import Ratatouille.View
  import SmurfTui.Panels.Helpers

  def topic(model) do
    row do
      column(size: 2) do
        panel([title: "Topics"] ++ title_style(:topics, model.active_panel)) do
          table do
            for i <- model.topics do
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
