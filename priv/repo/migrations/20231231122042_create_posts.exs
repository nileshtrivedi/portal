defmodule Studio.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string, null: false
      add :data, :map, null: false
      add :fields, :map, null: false, default: %{}
      add :portal_id, references(:portals, on_delete: :nothing, type: :uuid), null: false
      add :user_id, references(:users, on_delete: :nothing, type: :uuid), null: false
      add :parent_id, references(:posts, on_delete: :nothing, type: :uuid), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:posts, [:portal_id])
    create index(:posts, [:user_id])
    create index(:posts, [:parent_id])
  end
end
