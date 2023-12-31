defmodule Studio.Repo.Migrations.CreateFields do
  use Ecto.Migration

  def change do
    create table(:fields, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :scope, :string, null: false
      add :type, :string, null: false
      add :is_required, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
