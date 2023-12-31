defmodule Studio.PortalsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Studio.Portals` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        did: "some did",
        metadata: %{}
      })
      |> Studio.Portals.create_user()

    user
  end

  @doc """
  Generate a field.
  """
  def field_fixture(attrs \\ %{}) do
    {:ok, field} =
      attrs
      |> Enum.into(%{
        is_required: true,
        name: "some name",
        scope: "some scope",
        type: "some type"
      })
      |> Studio.Portals.create_field()

    field
  end

  @doc """
  Generate a portal.
  """
  def portal_fixture(attrs \\ %{}) do
    {:ok, portal} =
      attrs
      |> Enum.into(%{
        display_name: "some display_name",
        fields: %{},
        id: "7488a646-e31f-11e4-aace-600308960662",
        slug: "some slug",
        type: "some type"
      })
      |> Studio.Portals.create_portal()

    portal
  end

  @doc """
  Generate a member.
  """
  def member_fixture(attrs \\ %{}) do
    {:ok, member} =
      attrs
      |> Enum.into(%{
        fields: %{},
        role: "some role"
      })
      |> Studio.Portals.create_member()

    member
  end

  @doc """
  Generate a permission.
  """
  def permission_fixture(attrs \\ %{}) do
    {:ok, permission} =
      attrs
      |> Enum.into(%{
        action: "some action",
        criteria: "some criteria",
        scope: "some scope"
      })
      |> Studio.Portals.create_permission()

    permission
  end

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        data: %{},
        fields: %{},
        id: "7488a646-e31f-11e4-aace-600308960662",
        type: "some type"
      })
      |> Studio.Portals.create_post()

    post
  end
end
