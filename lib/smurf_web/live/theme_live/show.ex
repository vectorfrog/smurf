defmodule SmurfWeb.ThemeLive.Show do
  #  use Phoenix.VerifiedRoutes, endpoint: SmurfWeb.Endpoint, router: SmurfWeb.Router
  use Surface.LiveComponent
  alias SmurfWeb.Components.Lists.PortraitCard
  alias SmurfWeb.Components.Form.Button
  alias SmurfWeb.Components.Modal
  alias SmurfWeb.Components.Icon
  alias SmurfWeb.Components.Icons.IconPortrait
  alias Smurf.Codenames.Theme
  alias Smurf.Codenames.Codename

  prop theme, :map, required: true
  prop codename_form, :map, required: true
  prop codename_form_title, :string, default: "Create Codename"
  data codename_submit, :string, default: "create_codename"

  @impl true
  def handle_event("delete_theme", _params, socket) do
    Theme.destroy(socket.assigns.theme)

    {:noreply, push_patch(socket, to: "/themes")}
  end

  def handle_event("open_delete_theme_modal", _params, socket) do
    Modal.open("delete-theme-modal")
    {:noreply, socket}
  end

  def handle_event("close_delete_theme_modal", _params, socket) do
    SmurfWeb.Components.Modal.close("delete-theme-modal")
    {:noreply, socket}
  end

  def handle_event("add_codename", _params, socket) do
    SmurfWeb.Components.Modal.open("codename-form")

    {:noreply,
     assign(socket,
       codename_submit: "create_codename",
       codename_form_title: "Create Codename",
       codename_form: AshPhoenix.Form.for_create(Theme, :create) |> to_form()
     )}
  end

  def handle_event("delete_codename", %{"codename" => codename_id}, socket) do
    codename = get_codename(codename_id, socket)
    delete_codename(codename, socket)
  end

  def handle_event("show_edit_codename", %{"codename" => codename_id}, socket) do
    SmurfWeb.Components.Modal.open("codename-form")
    codename = get_codename(codename_id, socket)

    {:noreply,
     assign(socket,
       codename_submit: "update_codename",
       codename_form_title: codename.name,
       active_codename: codename,
       codename_form: AshPhoenix.Form.for_update(codename, :update) |> to_form()
     )}
  end

  def handle_event("create_codename", %{"form" => params}, socket) do
    case Codename.create(params) do
      {:ok, _codename} ->
        {:noreply, socket |> redirect(to: "/theme/#{socket.assigns.theme.slug}")}

      {:error, changeset} ->
        {:noreply, socket |> assign(codename_form: changeset |> to_form())}
    end
  end

  def handle_event("update_codename", %{"form" => params}, socket) do
    Ash.Changeset.for_update(socket.assigns.active_codename, :update, params)
    |> Codename.update()
    |> case do
      {:ok, _codename} ->
        {:noreply, socket |> redirect(to: "/theme/#{socket.assigns.theme.slug}")}

      {:error, changeset} ->
        {:noreply, socket |> assign(codename_form: changeset |> to_form())}
    end
  end

  def get_codename(codename_id, socket),
    do: Enum.find(socket.assigns.theme.codenames, &(&1.id == codename_id))

  def delete_codename(codename, socket) do
    case Codename.destroy(codename) do
      {:ok, _codename} ->
        {:noreply, remove_codename(codename, socket)}

      {:error, _changeset} ->
        {:noreply, socket}
    end
  end

  def remove_codename(%{} = codename, socket) do
    theme =
      socket.assigns.theme.codenames
      |> Enum.filter(&(&1.id != codename.id))

    assign(socket, :theme, theme)
  end
end
