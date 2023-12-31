defmodule Studio.Repo.Migrations.CreatePermissions do
  use Ecto.Migration

  def change do
    create table(:permissions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :scope, :string, null: false
      add :action, :string, null: false
      add :criteria, :text, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
