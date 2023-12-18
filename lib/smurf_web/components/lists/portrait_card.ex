defmodule SmurfWeb.Components.Lists.PortraitCard do
  @moduledoc """
  Circle image with text below.
  """
  use Surface.Component

  prop(class, :css_class)
  @doc "The image url to use in the portrait"
  prop(image, :string, required: true)

  @doc "The alt tag to use in the portrait image"
  prop(alt, :string, required: false)

  @doc "Default Slot"
  slot default

  @doc "action slot"
  slot actions

  def render(assigns) do
    ~F"""
    <li class={"flex flex-col divide-y divide-gray-200 rounded-lg bg-white overflow-hidden text-center shadow", @class}>
        <div class="flex flex-1 flex-col p-8">
          <img class="mx-auto h-32 w-32 flex-shrink-0 rounded-full" src={@image} alt={@alt}>
          <#slot />
        </div>
        <div>
          <div :if={slot_assigned?(:actions)} class="-mt-px flex divide-x divide-gray-200">
          <#slot {@actions}/>
          </div>
        </div>
      </li>
    """
  end
end
