defmodule SmurfTui do
  @behaviour Ratatouille.App

  import Ratatouille.View

  @impl true
  def init(model) do
    Map.put(model, :topics, Smurf.all_topics())
  end

  @impl true
  def update(model, _msg) do
    model
  end

  @impl true
  def render(model) do
    view do
      row do
        column(size: 6) do
          panel(height: :fill, title: "Tasks") do
          end
        end

        column(size: 6) do
          row do
            column(size: 12) do
              panel(title: "Details", height: model.window.height - 10) do
              end
            end
          end

          row do
            column(size: 12) do
              panel(title: "Help", height: 10) do
              end
            end
          end
        end
      end
    end
  end
end
