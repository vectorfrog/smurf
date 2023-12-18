defmodule SmurfWeb.Components.Modal do
  use Surface.LiveComponent

  #  alias Phoenix.LiveView.JS
  alias SmurfWeb.Components.Icon

  @doc "show/hide modal"
  data show, :boolean, default: false
  @doc "center or left align"
  prop layout, :string, values: ~w(center left), default: "center"
  @doc "action buttons"
  slot actions
  @doc "default slot"
  slot default

  def render(assigns) do
    ~F"""
    <html>
    <div class="relative z-10" :show={@show} aria-labelledby="modal-title" role="dialog" aria-modal="true">
      <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity;"></div>

      <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
        <div class={"flex min-h-full items-end p-4 sm:p-0 justify-center text-center sm:items-center"}>
          <div class="relative transform overflow-hidden rounded-lg bg-white px-4 pb-4 pt-5 text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg sm:p-6">
            <div class="absolute right-0 top-0 pr-4 pt-4 sm:block">
              <button type="button" :on-click="close" class="rounded-md bg-white text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
                <span class="sr-only">Close</span>
                <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>
            <div class="sm:flex sm:items-start">
              {#if @layout == "left"}
              <div class="mt-3 text-left sm:ml-4 sm:mt-0">
                <#slot />
              </div>
              {#else}
              <div class="mt-3 text-center sm:ml-4 sm:mt-0 flex flex-col">
                <#slot />
              </div>
              {/if}
            </div>
            <div class="mt-5 sm:mt-4 sm:flex sm:flex-row-reverse gap-2">
              <#slot {@actions} />
            </div>
          </div>
        </div>
      </div>
    </div>
    </html>
    """
  end

  # Public API
  def open(modal_id) do
    send_update(__MODULE__, id: modal_id, show: true)
  end

  def close(modal_id) do
    send_update(__MODULE__, id: modal_id, show: false)
  end

  # Default event handlers
  def handle_event("close", _, socket) do
    {:noreply, assign(socket, :show, false)}
  end
end
