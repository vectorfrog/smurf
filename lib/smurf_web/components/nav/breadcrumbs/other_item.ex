defmodule SmurfWeb.Components.Nav.Breadcrumbs.OtherItem do
  use Surface.Component
  prop(text, :string, required: true)
  prop(url, :string, required: true)

  defp render(assigns) do
    ~F"""
    <li>
      <div class="flex items-center">
        <svg class="h-5 w-5 flex-shrink-0 text-gray-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
          <path fill-rule="evenodd" d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z" clip-rule="evenodd" />
        </svg>
        <a href={@url} aria-current="page" class="ml-4 text-sm font-medium text-gray-500 hover:text-gray-700">{@text}</a>
      </div>
    </li>
    """
  end
end
