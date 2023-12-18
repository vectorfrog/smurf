defmodule SmurfWeb.Component.Layout.List do
  use Phoenix.Component

  slot(:inner_block, required: true)

  def three_col(assigns) do
    ~H"""
    <ul role="list" class="grid grid-cols-1 gap-x-6 gap-y-8 lg:grid-cols-3 xl:gap-x-8">
    <%= @inner_content %>
    </ul>
    """
  end
end
