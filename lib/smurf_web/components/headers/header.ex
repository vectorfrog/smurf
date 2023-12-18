defmodule SmurfWeb.Components.Header do
  use Surface.Component

  @moduledoc """
    Page Header component
  """

  @doc "Page title"
  prop(title, :string, required: true)
  @doc "Breadcrumbs slot"
  slot breadcrumbs
  @doc "icon pairs"
  slot icons
  @doc "action section for buttons"
  slot actions

  def render(assigns) do
    ~F"""
    <div class="lg:flex lg:items-center lg:justify-between">
      <div class="min-w-0 flex-1">
        <#slot {@breadcrumbs} />
        <h1 class="mt-2 text-2xl font-bold leading-7 text-gray-900 sm:truncate sm:text-3xl sm:tracking-tight">{@title}</h1>
        <div :if={slot_assigned?(:icons)} class="mt-1 flex flex-col sm:mt-0 sm:flex-row sm:flex-wrap sm:space-x-6">
          <#slot {@icons} />
        </div>
      </div>
      <div :if={slot_assigned?(:actions)} class="mt-5 flex lg:ml-4 lg:mt-0">
        <#slot {@actions} />
      </div>
    </div>
    """
  end
end
