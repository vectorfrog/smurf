defmodule SmurfWeb.Components.Nav.Breadcrumbs.FirstItem do
  use Surface.Component
  prop(text, :string, required: true)
  prop(url, :string, required: true)

  defp render(assigns) do
    ~F"""
    <li>
      <div class="flex">
        <a href={@url} class="text-sm font-medium text-gray-400 hover:text-gray-200">{@text}</a>
      </div>
    </li>
    """
  end
end
