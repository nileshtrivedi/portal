defmodule Studio.Portals.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "users" do
    field :metadata, :map
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    attrs =
      with true <- is_binary(attrs["metadata"]),
           {:ok, decoded_value} <- Jason.decode(attrs["metadata"]) do
        Map.put(attrs, "metadata", decoded_value)
      else
        _ -> attrs
      end

    user
    |> cast(attrs, [:metadata])
  end
end
