defmodule Studio.Portals.Portal do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "portals" do
    field :type, Ecto.Enum, values: [:chat, :course, :posts, :events, :container, :members]
    field :fields, :map
    field :display_name, :string
    field :slug, :string
    # field :parent_id, :id
    belongs_to :parent, Studio.Portals.Portal, foreign_key: :parent_id
    has_many :children, Studio.Portals.Portal, foreign_key: :parent_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(portal, attrs) do
    attrs =
      with true <- is_binary(attrs["fields"]),
           {:ok, decoded_value} <- Jason.decode(attrs["fields"]) do
        Map.put(attrs, "fields", decoded_value)
      else
        _ -> attrs
      end

    portal
    |> cast(attrs, [:display_name, :type, :slug, :fields, :parent_id])
    |> validate_required([:display_name, :type, :slug])
  end
end
