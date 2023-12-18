defmodule SmurfWeb.ThemeLive.CodenameForm do
  use Surface.Component
  import SmurfWeb.Components.Form.Input
  alias SmurfWeb.Components.Form.Button
  alias Surface.Components.Form
  alias Smurf.Codenames.Codename

  prop form, :map, required: true
  prop theme, :map, required: true
  prop title, :string, required: true
  prop submit, :event

  def render(assigns) do
    if assigns.title != "Create Codename",
      do: IO.inspect(assigns.form.source.data, label: "assigns")

    ~F"""
    <div>
    <h3 class="text-lg leading-6 font-medium text-gray-900">{@title}</h3>
    <Form for={@form} submit={@submit}>
      <.input type="hidden" field={@form[:theme_id]} value={@theme.id} />
      <.input type="text" label="Name" field={@form[:name]} />
      <.input type="text" label="Image" field={@form[:image]} />
      <Button style="outline" class="mt-3 w-full hover:text-white" phx-disable-with="Saving...">Save Codename</Button>
    </Form>
    </div>
    """
  end
end
