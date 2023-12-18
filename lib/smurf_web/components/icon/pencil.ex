defmodule SmurfWeb.Components.Icon.Pencil do
  use Surface.Component

  prop size, :integer, default: 4
  prop mini, :boolean, default: false
  prop outline, :boolean, default: false
  prop solid, :boolean, default: false
  prop class, :css_class

  def render(assigns) do
    ~F"""
    {#case {@outline, @solid, @mini} }
    {#match {false, false, true}}
      <span class={"hero-pencil-mini h-#{@size} w-#{@size}", @class} />
    {#match {true, false, false}}
      <span class={"hero-pencil h-#{@size} w-#{@size}", @class} />
    {#match {_, _, _}}
      <span class={"hero-pencil-solid h-#{@size} w-#{@size}", @class} />
    {/case}
    """
  end
end
