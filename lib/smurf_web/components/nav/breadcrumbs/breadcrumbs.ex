defmodule SmurfWeb.Components.Nav.Breadcrumbs do
  use Surface.Component
  alias SmurfWeb.Components.Nav.Breadcrumbs.{FirstItem, OtherItem}

  prop(crumbs, :list, required: true)

  def render(assigns) do
    ~F"""
    <div>
    <nav class="sm:hidden" aria-label="Back">
        <a href={get_back_url(@crumbs)} class="flex items-center text-sm font-medium text-gray-500 hover:text-gray-700">
          <svg class="-ml-1 mr-1 h-5 w-5 flex-shrink-0 text-gray-400" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M12.79 5.23a.75.75 0 01-.02 1.06L8.832 10l3.938 3.71a.75.75 0 11-1.04 1.08l-4.5-4.25a.75.75 0 010-1.08l4.5-4.25a.75.75 0 011.06.02z" clip-rule="evenodd" />
          </svg>
          Back
        </a>
      </nav>
      <nav class="hidden sm:flex" aria-label="Breadcrumb">
        <ol role="list" class="flex items-center space-x-4">
          {#for {{text, url}, index} <- @crumbs |> Enum.with_index()}
            {#if index == 0}
              <FirstItem {=url} {=text}/>
            {#else}
              <OtherItem {=url} {=text}/>
            {/if}
          {/for}
        </ol>
      </nav>
    </div>
    """
  end

  defp get_back_url(crumbs) do
    Enum.take(crumbs, -2)
    |> case do
      [_] -> "/"
      [h | _] -> h |> elem(1)
    end
  end
end
