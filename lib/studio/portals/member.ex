defmodule Studio.Portals.Member do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "members" do
    field :fields, :map
    field :role, :string
    # field :user_id, :id
    belongs_to :user, Studio.Portals.User
    # field :portal_id, :id
    belongs_to :portal, Studio.Portals.Portal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(member, attrs) do
    attrs =
      with true <- is_binary(attrs["fields"]),
           {:ok, decoded_value} <- Jason.decode(attrs["fields"]) do
        Map.put(attrs, "fields", decoded_value)
      else
        _ -> attrs
      end

    member
    |> cast(attrs, [:role, :fields])
    |> validate_required([:role])
  end
end
