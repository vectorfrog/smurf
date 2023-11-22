defmodule Smurf do
  alias Smurf.{CodeName, Topic, Repo}
  import Ecto.Query

  # ---------------------------------------- #
  # --------------- Topics ----------------- #
  # ---------------------------------------- #

  def add_topic(str) when is_binary(str), do: Repo.insert!(%Topic{name: str})
  def add_topic(%Topic{} = t), do: Repo.insert!(t)
  def all_topics(), do: Repo.all(Topic)
  def delete_topic(%Topic{} = t), do: Repo.delete(t)

  def update_topic(%Topic{} = t, str) do
    t |> Topic.changeset(%{name: str}) |> Repo.update()
  end

  # ---------------------------------------- #
  # -------------- CodeNames --------------- #
  # ---------------------------------------- #

  def add_codename(str, %Topic{} = topic) when is_binary(str),
    do: Repo.insert!(%CodeName{name: str, topic: topic})

  def all_codenames(), do: Repo.all(CodeName)

  def get_codenames(%Topic{} = t) do
    query = from(c in CodeName, where: [topic_id: ^t.id], preload: [:topic])
    Repo.all(query)
  end

  def delete_codename(%CodeName{} = c), do: Repo.delete(c)

  def update_codename(%CodeName{} = c, str) do
    c |> CodeName.changeset(%{name: str}) |> Repo.update()
  end
end
