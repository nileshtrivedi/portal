defmodule Studio.Repo.Migrations.CreatePortals do
  use Ecto.Migration

  def change do
    create table(:portals, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :display_name, :string, null: false
      add :type, :string, null: false
      add :slug, :string, null: false
      add :fields, :map, null: false, default: %{}
      add :parent_id, references(:portals, on_delete: :nothing, type: :uuid)

      timestamps(type: :utc_datetime)
    end

    create index(:portals, [:parent_id])
  end
end
