defmodule SmurfWeb.Components.Icon.Trash do
  use Surface.Component

  prop(mini, :boolean, default: false)
  prop(outline, :boolean, default: false)
  prop(solid, :boolean, default: false)
  prop(class, :css_class)

  def render(assigns) do
    ~F"""
    {#case {@outline, @solid, @mini} }
    {#match {false, false, true}}
      <span class={"hero-trash-mini", @class} />
    {#match {true, false, false}}
      <span class={"hero-trash", @class} />
    {#match {_, _, _}}
      <span class={"hero-trash-solid", @class} />
    {/case}
    """
  end
end
