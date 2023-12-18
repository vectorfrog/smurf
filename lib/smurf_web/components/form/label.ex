defmodule SmurfWeb.Components.Form.Label do
  use Phoenix.Component

  @doc """
  Renders a label.
  """
  attr(:for, :string, default: nil)
  attr(:type, :string, default: "default", values: ~w(default inset overlap))
  attr(:bg, :string, default: "bg-white")
  slot(:inner_block, required: true)

  def label(%{type: "default"} = assigns) do
    ~H"""
    <label for={@for} class="block text-sm font-medium leading-6 text-base-900">
      <%= render_slot(@inner_block) %>
    </label>
    """
  end

  def label(%{type: "inset"} = assigns) do
    ~H"""
    <label for={@for} class="block text-xs font-medium leading-6 text-base-900">
      <%= render_slot(@inner_block) %>
    </label>
    """
  end

  def label(%{type: "overlap"} = assigns) do
    ~H"""
    <label
      for={@for}
      class={"absolute -top-2 left-2 inline-block #{@bg} px-1 text-xs font-medium  text-base-900"}
    >
      <%= render_slot(@inner_block) %>
    </label>
    """
  end
end
