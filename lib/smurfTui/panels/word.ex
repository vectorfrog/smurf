defmodule SmurfTui.Panels.Word do
  import Ratatouille.View
  import SmurfTui.Panels.Helpers

  import Ratatouille.Constants, only: [key: 1]
  @spacebar key(:space)

  def model, do: get_random(Smurf.all_codenames())

  def update_word(model, msg) do
    case {model, msg} do
      {_, {:event, %{key: @spacebar}}} ->
        put_in(model, [:word], get_random(Smurf.all_codenames()))

      {_, {:event, map}} ->
        %{model | key: map}
    end
  end

  def word(%{word: word} = model) do
    row do
      column(size: 5) do
      end

      column(size: 2) do
        panel([title: "Random CodeName"] ++ title_style(:word, model.active_panel)) do
          label([content: word] ++ bg_style(:word, model.active_panel))
        end
      end

      column(size: 5) do
      end
    end
  end

  def get_random(l) do
    l |> Enum.random() |> Map.get(:name)
  end
end
