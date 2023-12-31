defmodule Studio.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :role, :string, null: false
      add :fields, :map, null: false, default: %{}
      add :user_id, references(:users, on_delete: :nothing, type: :uuid), null: false
      add :portal_id, references(:portals, on_delete: :nothing, type: :uuid), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:members, [:user_id])
    create index(:members, [:portal_id])
  end
end
