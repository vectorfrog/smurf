defmodule SmurfWeb.Components.Form.Input do
  import SmurfWeb.Components.Form.Error
  import SmurfWeb.Components.Form.Label
  use Phoenix.Component

  @doc """
  Renders an input with label and error messages.

  A `%Phoenix.HTML.Form{}` and field name may be passed to the input
  to build input names and error messages, or all the attributes and
  errors may be passed explicitly.

  ## Examples

      <.input field={@form[:email]} type="email" />
      <.input name="my-input" errors={["oh no!"]} />
  """
  attr(:id, :any, default: nil)
  attr(:name, :any)
  attr(:label, :string, default: nil)
  attr(:value, :any)
  attr(:class, :string, default: "")

  attr(:type, :string,
    default: "text",
    values: ~w(checkbox color date datetime-local email file hidden month number password
               range radio search select tel text textarea time url week)
  )

  attr(:field, Phoenix.HTML.FormField,
    doc: "a form field struct retrieved from the form, for example: @form[:email]"
  )

  attr(:errors, :list, default: [])
  attr(:checked, :boolean, doc: "the checked flag for checkbox inputs")
  attr(:prompt, :string, default: nil, doc: "the prompt for select inputs")
  attr(:options, :list, doc: "the options to pass to Phoenix.HTML.Form.options_for_select/2")
  attr(:multiple, :boolean, default: false, doc: "the multiple flag for select inputs")
  attr(:scheme, :string, default: "default", values: ~w(default inset overlap))
  attr(:corners, :boolean, default: false)

  attr(:rest, :global,
    include: ~w(autocomplete cols disabled form list max maxlength min minlength
                pattern placeholder readonly required rows size step)
  )

  slot(:inner_block)

  def input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign(:errors, Enum.map(field.errors, &translate_error(&1)))
    |> assign_new(:name, fn -> if assigns.multiple, do: field.name <> "[]", else: field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> assign(:scheme, assigns.scheme)
    |> assign(:corners, get_corners(assigns.class))
    |> input()
  end

  def input(%{type: "checkbox", value: value} = assigns) do
    assigns =
      assign_new(assigns, :checked, fn -> Phoenix.HTML.Form.normalize_value("checkbox", value) end)

    ~H"""
    <div phx-feedback-for={@name}>
      <label class="flex items-center gap-4 text-sm leading-6 text-zinc-600">
        <input type="hidden" name={@name} value="false" />
        <input
          type="checkbox"
          id={@id}
          name={@name}
          value="true"
          checked={@checked}
          class="rounded border-zinc-300 text-zinc-900 focus:ring-0"
          {@rest}
        />
        <%= @label %>
      </label>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  def input(%{type: "select"} = assigns) do
    ~H"""
    <div phx-feedback-for={@name}>
      <.label for={@id}><%= @label %></.label>
      <select
        id={@id}
        name={@name}
        class="mt-1 block w-full rounded-md border border-gray-300 bg-white shadow-sm focus:border-zinc-400 focus:ring-0 sm:text-sm"
        multiple={@multiple}
        {@rest}
      >
        <option :if={@prompt} value=""><%= @prompt %></option>
        <%= Phoenix.HTML.Form.options_for_select(@options, @value) %>
      </select>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  def input(%{type: "textarea"} = assigns) do
    ~H"""
    <div phx-feedback-for={@name}>
      <.label for={@id}><%= @label %></.label>
      <textarea
        id={@id}
        name={@name}
        class={[
          "mt-2 block w-full rounded-lg text-zinc-900 focus:ring-0 sm:text-sm sm:leading-6",
          "phx-no-feedback:border-zinc-300 phx-no-feedback:focus:border-zinc-400",
          "min-h-[6rem] border-zinc-300 focus:border-zinc-400",
          @errors != [] && "border-rose-400 focus:border-rose-400"
        ]}
        {@rest}
      ><%= Phoenix.HTML.Form.normalize_value("textarea", @value) %></textarea>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  # All other inputs text, datetime-local, url, password, etc. are handled here...
  def input(%{scheme: "inset"} = assigns) do
    ~H"""
    <div
      phx-feedback-for={@name}
      class={[
        if(@corners) do
          ""
        else
          "rounded-md"
        end,
        "px-3 pb-1.5 pt-2.5 shadow-sm ring-1 ring-inset ring-base-400",
        "focus-within:ring-2 focus-within:ring-base-600"
      ]}
    >
      <.label for={@id} type="inset"><%= @label %></.label>
      <input
        type={@type}
        name={@name}
        id={@id}
        value={Phoenix.HTML.Form.normalize_value(@type, @value)}
        class={[
          "block w-full border-0 p-0 rounded-lg text-base-900 placeholder:text-base-400 focus:ring-0 sm:text-sm sm:leading-6",
          "phx-no-feedback:border-base-300 phx-no-feedback:focus:border-base-400",
          @errors != [] && "border-error-400 focus:border-base-400"
        ]}
        {@rest}
      />
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  def input(%{scheme: "overlap"} = assigns) do
    ~H"""
    <div phx-feedback-for={@name} class="relative">
      <.label for={@id} type="overlap"><%= @label %></.label>
      <input
        type={@type}
        name={@name}
        id={@id}
        value={Phoenix.HTML.Form.normalize_value(@type, @value)}
        class={[
          "block w-full #{if @corners do
            ""
          else
            "rounded-md"
          end}",
          "border-0 py-1.5 text-base-900 shadow-sm ring-1 ring-inset ring-gray-300",
          "placeholder:text-base-400 focus:ring-2 focus:ring-inset",
          "focus:ring-primary-600 sm:text-sm sm:leading-6",
          "phx-no-feedback:border-base-300 phx-no-feedback:focus:border-base-400",
          @errors != [] && "border-error-400 focus:border-base-400"
        ]}
        {@rest}
      />
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  def input(assigns) do
    ~H"""
    <div phx-feedback-for={@name} class="w-full">
      <div>
        <.label for={@id}><%= @label %></.label>
        <div class="relative mt-2">
          <input
            type={@type}
            name={@name}
            id={@id}
            value={Phoenix.HTML.Form.normalize_value(@type, @value)}
            class={[
              "mt-2 block w-full #{if @corners do
                ""
              else
                "rounded-lg"
              end}",
              "text-base-900 focus:ring-0 sm:text-sm sm:leading-6",
              "phx-no-feedback:border-base-300 phx-no-feedback:focus:border-base-400",
              "border-base-400",
              @errors != [] && "border-error-400 focus:border-error-400"
            ]}
            {@rest}
          />
          <div class={[
            "phx-no-feedback:hidden pointer-events-none absolute inset-y-0 right-0 flex items-center pr-3",
            @errors == [] && "hidden"
          ]}>
            <Heroicons.exclamation_circle mini class="h-5 w-5 border-error-600" />
          </div>
        </div>
        <.error :for={msg <- @errors}><%= msg %></.error>
      </div>
    </div>
    """
  end

  defp get_corners(class_str) do
    l = String.split(class_str, ~r/\s+/)

    cond do
      Enum.member?(l, "box") -> true
      true -> false
    end
  end
end
