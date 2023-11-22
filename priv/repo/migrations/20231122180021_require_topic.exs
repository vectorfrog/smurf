defmodule Smurf.Repo.Migrations.RequireTopic do
  use Ecto.Migration

  def change do
  alter table(:codenames) do
    remove :topic_id
    add :topic_id, references(:topics, on_delete: :delete_all, null: false)
  end
  end
end
