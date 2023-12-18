defmodule SmurfWeb.Components.Form.Error do
  #  @parent __MODULE__ |> Module.split() |> Enum.drop(-1) |> Module.concat()
  #  @core Module.concat(@parent, CoreComponents)
  use Phoenix.Component

  #  import Heroicon

  # defdelegate error(assigns), to: @core
  #  defdelegate tranlate_error(tuple_param), to: @core
  # defdelegate tranlate_errors(errors, field), to: @core
  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # You can make use of gettext to translate error messages by
    # uncommenting and adjusting the following code:

    # if count = opts[:count] do
    #   Gettext.dngettext(ComponentsWeb.Gettext, "errors", msg, msg, count, opts)
    # else
    #   Gettext.dgettext(ComponentsWeb.Gettext, "errors", msg, opts)
    # end

    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", fn _ -> to_string(value) end)
    end)
  end

  @doc """
  Translates the errors for a field from a keyword list of errors.
  """
  def translate_errors(errors, field) when is_list(errors) do
    for {^field, {msg, opts}} <- errors, do: translate_error({msg, opts})
  end

  @doc """
  Generates a generic error message.
  """
  slot(:inner_block, required: true)

  def error(assigns) do
    ~H"""
    <p class="mt-1 flex gap-3 text-sm leading-6 text-error-600 phx-no-feedback:hidden">
      <%= render_slot(@inner_block) %>
    </p>
    """
  end
end
