defmodule Smurf.Repo.Migrations.CodenameTopics do
  use Ecto.Migration

  def change do
    create table(:codenames) do
      add :name, :string
      add :topic_id, references(:topics, on_delete: :delete_all)
      timestamps()
    end
    create table(:topics) do
      add :name, :string
      timestamps()
    end
  end
end
