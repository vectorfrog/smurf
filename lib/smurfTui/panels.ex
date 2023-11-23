defmodule SmurfTui.Panels do
  defdelegate topic(model), to: SmurfTui.Panels.Topic
  defdelegate codenames(model), to: SmurfTui.Panels.CodeNames
  defdelegate word(model), to: SmurfTui.Panels.Word
  defdelegate topbar(model), to: SmurfTui.Panels.Helpers
end
