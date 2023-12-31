defmodule Studio.Portals.Field do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "fields" do
    field :name, :string
    field :scope, :string
    field :type, Ecto.Enum, values: [:foo, :bar, :baz]
    field :is_required, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(field, attrs) do
    field
    |> cast(attrs, [:name, :scope, :type, :is_required])
    |> validate_required([:name, :scope, :type, :is_required])
  end
end
