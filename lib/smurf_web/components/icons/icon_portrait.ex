defmodule SmurfWeb.Components.Icons.IconPortrait do
  use Surface.Component

  prop class, :css_class
  prop size, :integer, default: 12
  slot default

  def render(assigns) do
    ~F"""
    <div class={"mx-auto flex h-#{@size} w-#{@size} items-center justify-center rounded-full sm:mx-0 sm:h-10 sm:w-10 flex-shrink-0", @class}>
      <#slot />
    </div>
    """
  end
end
