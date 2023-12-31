defmodule Studio.Portals.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "permissions" do
    field :scope, :string
    field :action, :string
    field :criteria, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [:scope, :action, :criteria])
    |> validate_required([:scope, :action, :criteria])
  end
end
