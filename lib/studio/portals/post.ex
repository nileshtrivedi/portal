defmodule Studio.Portals.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "posts" do
    field :data, :map
    field :type, Ecto.Enum, values: [:chat]
    field :fields, :map
    # field :portal_id, :id
    belongs_to :portal, Studio.Portals.Portal
    # field :user_id, :id
    belongs_to :user, Studio.Portals.User
    # field :parent_id, :id
    belongs_to :parent, Studio.Portals.Post, foreign_key: :parent_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    attrs =
      with true <- is_binary(attrs["fields"]),
           {:ok, decoded_value} <- Jason.decode(attrs["fields"]) do
        Map.put(attrs, "fields", decoded_value)
      else
        _ -> attrs
      end

    post
    |> cast(attrs, [:type, :data, :fields])
    |> validate_required([:type])
  end
end
