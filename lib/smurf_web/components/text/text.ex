defmodule SmurfWeb.Components.Text do
  use Phoenix.Component
  import TailColors

  attr(:class, :string, default: "")
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def h1(assigns) do
    ~H"""
    <h1
      class={tw(["mt-2 text-3xl font-bold tracking-tight text-base-950 sm:text-4xl", @class])}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </h1>
    """
  end

  attr(:class, :string, default: "")
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def h2(assigns) do
    ~H"""
    <h2 class={tw(["mt-16 text-2xl font-bold tracking-tight text-base-900", @class])} {@rest}>
      <%= render_slot(@inner_block) %>
    </h2>
    """
  end

  attr(:class, :string, default: "")
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def sub_title(assigns) do
    ~H"""
    <p class={tw(["text-base font-semibold leading-7 text-primary", @class])}>
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  attr(:class, :string, default: "")
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def intro(assigns) do
    ~H"""
    <p class={tw(["mt-6 text-xl leading-8 text-base-700", @class])}>
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  attr(:class, :string, default: "")
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def p(assigns) do
    ~H"""
    <p class={tw(["mt-10 max-w-xl text-base leading-7 text-base-700 lg:max-w-none", @class])}>
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  attr(:class, :string, default: "")
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def ul(assigns) do
    ~H"""
    <ul role="list" class={tw(["mt-8 space-y-8 text-base-600", @class])}>
      <%= render_slot(@inner_block) %>
    </ul>
    """
  end

  attr(:class, :string, default: "")
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def li(assigns) do
    ~H"""
    <li class={tw(["flex gap-x-3", @class])}>
      <%= render_slot(@inner_block) %>
    </li>
    """
  end

  attr(:class, :string, default: "")
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def strong(assigns) do
    ~H"""
    <strong class={tw(["font-semibold text-base-900", @class])}>
      <%= render_slot(@inner_block) %>
    </strong>
    """
  end
end
