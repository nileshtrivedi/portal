defmodule Studio.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :metadata, :map, null: false, default: %{}

      timestamps(type: :utc_datetime)
    end
  end
end
