defmodule SmurfTui.Panels do
  defdelegate update_topics(model, msg), to: SmurfTui.Panels.Topic
  defdelegate topic(model), to: SmurfTui.Panels.Topic
  defdelegate update_codenames(model, msg), to: SmurfTui.Panels.CodeNames
  defdelegate codenames(model), to: SmurfTui.Panels.CodeNames
  defdelegate update_word(model, msg), to: SmurfTui.Panels.Word
  defdelegate word(model), to: SmurfTui.Panels.Word
  defdelegate topbar(model), to: SmurfTui.Panels.Helpers
  defdelegate bottombar(model), to: SmurfTui.Panels.Helpers
end
