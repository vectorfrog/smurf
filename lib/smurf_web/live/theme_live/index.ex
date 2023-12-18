defmodule SmurfWeb.ThemeLive.Index do
  use Surface.LiveComponent
  alias SmurfWeb.Components.Form.Button
  alias Surface.Components.LivePatch
  alias SmurfWeb.Components.Modal

  prop action, :atom, required: true
  prop themes, :list, required: true
  prop form, :any, required: true
  prop submit, :event
  prop title, :string
  prop theme, :any

  def render(assigns) do
    ~F"""
    <div>
    <div>
      <span class="text-xl font-bold">Themes</span>
      <Button color="primary" style="outline" click="show_theme_form" class="ml-4 hover:text-white ">Add Theme</Button>
    </div>

    <ul role="list" class="mt-4 grid grid-cols-1 gap-x-6 gap-y-8 lg:grid-cols-3 xl:gap-x-8">
      <li :for={theme <- @themes} class="overflow-hidden rounded-xl border border-gray-200">
      <LivePatch to={"/theme/#{theme.slug}"}>
        <div class="flex items-center gap-x-4 border-b border-gray-900/5 bg-gray-50 p-6">
          <img src={"https://res.cloudinary.com/dlghkugkv/image/upload/h_48,w_48,c_thumb,g_face/v1701903012/#{theme.image}"} alt={theme.name} class="h-12 w-12 flex-none rounded-lg bg-white object-cover ring-1 ring-gray-900/10">
          <div class="text-sm font-medium leading-6 text-gray-900">{ theme.name }</div>
        </div>
       </LivePatch>
        <dl class="-my-3 divide-y divide-gray-100 px-6 py-4 text-sm leading-6">
          <div class="flex justify-between gap-x-4 py-3">
            <dt class="text-gray-500">Total Codenames</dt>
            <dd class="text-gray-700">{theme.count}</dd>
          </div>
          <div class="flex justify-between gap-x-4 py-3">
            <dt class="text-gray-500">Amount</dt>
            <dd class="flex items-start gap-x-2">
              <div class="font-medium text-gray-900">$2,000.00</div>
              <div class="rounded-md py-1 px-2 text-xs font-medium ring-1 ring-inset text-red-700 bg-red-50 ring-red-600/10">Overdue</div>
            </dd>
          </div>
        </dl>
      </li>
    </ul>
    <Modal layout="left" id="theme-form">
      <SmurfWeb.ThemeLive.Form title={@title} submit={@submit} form={@form} id="create-codename-form" />
    </Modal>
    </div>
    """
  end

  def handle_event("show_theme_form", _, socket) do
    Modal.open("theme-form")
    {:noreply, socket}
  end
end
