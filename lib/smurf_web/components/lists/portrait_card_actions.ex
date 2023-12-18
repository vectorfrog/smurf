defmodule SmurfWeb.Components.Lists.PortraitCard.Action do
  @moduledoc """
  Icon Buttons for Portrait Card
  """
  use Surface.Component

  prop icon, :string, required: false
  prop text, :string, required: true
  prop class, :css_class
  prop click, :event
  prop codename_id, :string

  def render(assigns) do
    ~F"""
    <div class={"-ml-px flex w-0 flex-1 cursor-pointer", @class} :on-click={@click} :values={codename_id: @codename_id}>
      <div href="tel:+1-202-555-0170" class="relative inline-flex w-0 flex-1 items-center justify-center gap-x-3 rounded-br-lg border border-transparent py-4 text-sm font-semibold text-gray-900">
        <span class={"h-5 w-5 text-gray-400 #{@icon}"}></span>
      {@text}
      </div>
    </div>
    """
  end
end
