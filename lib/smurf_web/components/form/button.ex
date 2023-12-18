defmodule SmurfWeb.Components.Form.Button do
  use Surface.Component

  @moduledoc """
  Clasic button component.
  This assumes that you are using the recommended tailwind configuration with the following custom colors:

  - primary
  - secondary
  - accent
  - base
  - info
  - success
  - warning
  - error

  # Examples

      <Button>Send!</Button>
  """

  @doc "the event to trigger on click"
  prop click, :event
  @doc "css classes to add to the button"
  prop class, :css_class
  @doc "style of the button (ghost, outline, default)"
  prop style, :string, values: ~w(default ghost outline), default: "default"
  @doc "shape of the button"
  prop shape, :string, values: ~w(default box circle), default: "default"
  @doc "size of the button"
  prop size, :string, values: ~w(xs sm md lg xl), default: "md"
  @doc "use primary color scheme"
  prop color, :string,
    values: ~w(primary secondary accent base info success warning error),
    default: "primary"

  @doc "does button contain an icon?"
  prop(icon, :boolean, default: false)

  @doc "default slot"
  slot default, required: true

  @doc """
      <GilderoyWeb.Components.Button>Send!</GilderoyWeb.Components.Button>
  """
  def render(assigns) do
    ~F"""
    <style>
      .btn {
      @apply justify-center inline-flex items-center font-medium focus:outline-none focus:ring-2 focus:ring-offset-2 hover:transition-all duration-300 ring-primary-500;
      }
    </style>
    <button :on-click={@click} class={text_size(@size), colors(@color, @style), corners(@shape), padding(@size, @shape, @icon), "btn", @class}>
      <#slot/>
    </button>
    """
  end

  defp corners("box"), do: ""
  defp corners("circle"), do: "rounded-full"
  defp corners(_), do: "rounded-md"

  defp colors("primary", "default"), do: "bg-primary text-base-50 hover:bg-primary-800"
  defp colors("secondary", "default"), do: "bg-secondary text-base-50 hover:bg-secondary-800"
  defp colors("accent", "default"), do: "bg-accent text-base-50 hover:bg-accent-800"
  defp colors("base", "default"), do: "bg-base text-base-900 hover:bg-base-200"
  defp colors("info", "default"), do: "bg-info text-base-50 hover:bg-info-800"
  defp colors("success", "default"), do: "bg-success text-base-50 hover:bg-success-800"
  defp colors("warning", "default"), do: "bg-warning text-base-50 hover:bg-warning-800"
  defp colors("error", "default"), do: "bg-error text-base-50 hover:bg-error-800"

  defp colors("primary", "outline"),
    do: "text-primary border border-1 border-primary hover:bg-primary hover:text-base-50"

  defp colors("secondary", "outline"),
    do: "text-secondary border border-1 border-secondary hover:bg-secondary hover:text-base-50"

  defp colors("accent", "outline"),
    do: "text-accent border border-1 border-accent hover:bg-accent hover:text-base-50"

  defp colors("base", "outline"),
    do: "text-base border border-1 border-base hover:bg-base hover:text-base-50"

  defp colors("info", "outline"),
    do: "text-info border border-1 border-info hover:bg-info hover:text-base-50"

  defp colors("success", "outline"),
    do: "text-success border border-1 border-success hover:bg-success hover:text-base-50"

  defp colors("warning", "outline"),
    do: "text-warning border border-1 border-warning hover:bg-warning hover:text-base-50"

  defp colors("error", "outline"),
    do: "text-error border border-1 border-error hover:bg-error hover:text-base-50"

  defp colors("primary", "ghost"), do: "text-primary hover:bg-opacity-30 hover:bg-primary"
  defp colors("secondary", "ghost"), do: "text-secondary hover:bg-opacity-30 hover:bg-secondary"
  defp colors("accent", "ghost"), do: "text-accent hover:bg-opacity-30 hover:bg-accent"
  defp colors("base", "ghost"), do: "text-base hover:bg-opacity-30 hover:bg-base"
  defp colors("info", "ghost"), do: "text-info hover:bg-opacity-30 hover:bg-info"
  defp colors("success", "ghost"), do: "text-success hover:bg-opacity-30 hover:bg-success"
  defp colors("warning", "ghost"), do: "text-warning hover:bg-opacity-30 hover:bg-warning"
  defp colors("error", "ghost"), do: "text-error hover:bg-opacity-30 hover:bg-error"

  defp text_size("xs"), do: "text-xs"
  defp text_size("sm"), do: "text-sm"
  defp text_size("md"), do: "text-md"
  defp text_size("lg"), do: "text-lg"
  defp text_size("xl"), do: "text-xl"

  defp padding("xs", "circle", true), do: "p-1"
  defp padding("sm", "circle", true), do: "p-1.5"
  defp padding("md", "circle", true), do: "p-2"
  defp padding("lg", "circle", true), do: "p-2"
  defp padding("xl", "circle", true), do: "p-3"
  defp padding("xs", "circle", false), do: "px-2 py-1"
  defp padding("sm", "circle", false), do: "px-3 py-2"
  defp padding("md", "circle", false), do: "px-4 py-2.5"
  defp padding("lg", "circle", false), do: "px-5 py-2.5"
  defp padding("xl", "circle", false), do: "px-6 py-3"
  defp padding("xs", _shape, false), do: "px-2.5 py-1.5"
  defp padding("sm", _shape, false), do: "px-3 py-2"
  defp padding("xl", _shape, false), do: "px-6 py-3"
  defp padding(_size, _shape, false), do: "px-4 py-2"
  defp padding("xs", _shape, true), do: "px-3 py-2"
  defp padding("sm", _shape, true), do: "px-4 py-2"
  defp padding("xl", _shape, true), do: "px-6 py-3"
  defp padding(_size, _shape, true), do: "px-4 py-2"
end
