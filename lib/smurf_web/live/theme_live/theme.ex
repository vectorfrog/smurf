defmodule SmurfWeb.ThemeLive.Theme do
  use Surface.LiveView
  alias Smurf.Codenames.Theme
  alias Smurf.Codenames.Codename

  #    <SmurfWeb.ThemeLive.Form.create create_form={@create_form}/>
  def render(assigns) do
    ~F"""
    <SmurfWeb.ThemeLive.Show :if={@theme && @action == :show} {=@codename_form} {=@theme} id="theme-show" />
    <SmurfWeb.ThemeLive.Index :if={@action == :index} {=@themes} form={@theme_form} id="theme-index" />
    """
  end

  def handle_params(params, _uri, %{assigns: %{live_action: action}} = socket) do
    socket =
      socket
      |> assign(action: action)
      |> assure_themes()
      |> set_theme(params)

    {:noreply, socket}
  end

  def mount(params, _session, socket) do
    socket =
      if connected?(socket) do
        socket |> assure_themes()
      else
        socket |> assign(:themes, [])
      end
      |> assign(theme_form: AshPhoenix.Form.for_create(Theme, :create) |> to_form())
      |> assign(codename_form: AshPhoenix.Form.for_create(Codename, :create) |> to_form())
      |> set_theme(params)

    {:ok, socket}
  end

  def handle_event("create_theme", %{"form" => %{"name" => name, "image" => image}}, socket) do
    Theme.create(name, image)

    {:noreply, socket |> assign(:themes, load_themes())}
  end

  defp load_themes() do
    Theme.read!() |> Enum.map(&Smurf.Codenames.load!(&1, [:slug, :count]))
  end

  defp load_theme(slug, themes) do
    themes |> Enum.find(&(&1.slug == slug)) |> Smurf.Codenames.load!(:codenames)
  end

  defp assure_themes(socket) do
    themes = load_themes()
    socket |> assign(:themes, themes)
  end

  defp set_theme(socket, params) do
    case Map.get(params, "theme_slug", nil) do
      nil -> socket |> assign(theme: nil)
      slug -> socket |> assign(theme: load_theme(slug, socket.assigns.themes))
    end
  end
end
