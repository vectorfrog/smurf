defmodule SmurfWeb.ThemeLive.Form do
  use Surface.Component
  import SmurfWeb.Components.Form.Input
  alias SmurfWeb.Components.Form.Button

  prop form, :map, required: true

  def render(assigns) do
    ~F"""
    <.form for={@form} phx-submit="create_theme">
      <.input scheme="inset" type="text" label="Name" field={@form[:name]} />
      <.input scheme="inset" type="text" label="Image" field={@form[:image]} />
      <Button class="outline" phx-disable-with="Saving...">Save Product</Button>
    </.form>
    """
  end
end
