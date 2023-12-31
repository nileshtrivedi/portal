defmodule Studio.PortalsTest do
  use Studio.DataCase

  alias Studio.Portals

  describe "users" do
    alias Studio.Portals.User

    import Studio.PortalsFixtures

    @invalid_attrs %{metadata: nil, did: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Portals.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Portals.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{metadata: %{}, did: "some did"}

      assert {:ok, %User{} = user} = Portals.create_user(valid_attrs)
      assert user.metadata == %{}
      assert user.did == "some did"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portals.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{metadata: %{}, did: "some updated did"}

      assert {:ok, %User{} = user} = Portals.update_user(user, update_attrs)
      assert user.metadata == %{}
      assert user.did == "some updated did"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Portals.update_user(user, @invalid_attrs)
      assert user == Portals.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Portals.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Portals.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Portals.change_user(user)
    end
  end

  describe "fields" do
    alias Studio.Portals.Field

    import Studio.PortalsFixtures

    @invalid_attrs %{name: nil, scope: nil, type: nil, is_required: nil}

    test "list_fields/0 returns all fields" do
      field = field_fixture()
      assert Portals.list_fields() == [field]
    end

    test "get_field!/1 returns the field with given id" do
      field = field_fixture()
      assert Portals.get_field!(field.id) == field
    end

    test "create_field/1 with valid data creates a field" do
      valid_attrs = %{name: "some name", scope: "some scope", type: "some type", is_required: true}

      assert {:ok, %Field{} = field} = Portals.create_field(valid_attrs)
      assert field.name == "some name"
      assert field.scope == "some scope"
      assert field.type == "some type"
      assert field.is_required == true
    end

    test "create_field/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portals.create_field(@invalid_attrs)
    end

    test "update_field/2 with valid data updates the field" do
      field = field_fixture()
      update_attrs = %{name: "some updated name", scope: "some updated scope", type: "some updated type", is_required: false}

      assert {:ok, %Field{} = field} = Portals.update_field(field, update_attrs)
      assert field.name == "some updated name"
      assert field.scope == "some updated scope"
      assert field.type == "some updated type"
      assert field.is_required == false
    end

    test "update_field/2 with invalid data returns error changeset" do
      field = field_fixture()
      assert {:error, %Ecto.Changeset{}} = Portals.update_field(field, @invalid_attrs)
      assert field == Portals.get_field!(field.id)
    end

    test "delete_field/1 deletes the field" do
      field = field_fixture()
      assert {:ok, %Field{}} = Portals.delete_field(field)
      assert_raise Ecto.NoResultsError, fn -> Portals.get_field!(field.id) end
    end

    test "change_field/1 returns a field changeset" do
      field = field_fixture()
      assert %Ecto.Changeset{} = Portals.change_field(field)
    end
  end

  describe "portals" do
    alias Studio.Portals.Portal

    import Studio.PortalsFixtures

    @invalid_attrs %{id: nil, type: nil, fields: nil, display_name: nil, slug: nil}

    test "list_portals/0 returns all portals" do
      portal = portal_fixture()
      assert Portals.list_portals() == [portal]
    end

    test "get_portal!/1 returns the portal with given id" do
      portal = portal_fixture()
      assert Portals.get_portal!(portal.id) == portal
    end

    test "create_portal/1 with valid data creates a portal" do
      valid_attrs = %{id: "7488a646-e31f-11e4-aace-600308960662", type: "some type", fields: %{}, display_name: "some display_name", slug: "some slug"}

      assert {:ok, %Portal{} = portal} = Portals.create_portal(valid_attrs)
      assert portal.id == "7488a646-e31f-11e4-aace-600308960662"
      assert portal.type == "some type"
      assert portal.fields == %{}
      assert portal.display_name == "some display_name"
      assert portal.slug == "some slug"
    end

    test "create_portal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portals.create_portal(@invalid_attrs)
    end

    test "update_portal/2 with valid data updates the portal" do
      portal = portal_fixture()
      update_attrs = %{id: "7488a646-e31f-11e4-aace-600308960668", type: "some updated type", fields: %{}, display_name: "some updated display_name", slug: "some updated slug"}

      assert {:ok, %Portal{} = portal} = Portals.update_portal(portal, update_attrs)
      assert portal.id == "7488a646-e31f-11e4-aace-600308960668"
      assert portal.type == "some updated type"
      assert portal.fields == %{}
      assert portal.display_name == "some updated display_name"
      assert portal.slug == "some updated slug"
    end

    test "update_portal/2 with invalid data returns error changeset" do
      portal = portal_fixture()
      assert {:error, %Ecto.Changeset{}} = Portals.update_portal(portal, @invalid_attrs)
      assert portal == Portals.get_portal!(portal.id)
    end

    test "delete_portal/1 deletes the portal" do
      portal = portal_fixture()
      assert {:ok, %Portal{}} = Portals.delete_portal(portal)
      assert_raise Ecto.NoResultsError, fn -> Portals.get_portal!(portal.id) end
    end

    test "change_portal/1 returns a portal changeset" do
      portal = portal_fixture()
      assert %Ecto.Changeset{} = Portals.change_portal(portal)
    end
  end

  describe "members" do
    alias Studio.Portals.Member

    import Studio.PortalsFixtures

    @invalid_attrs %{fields: nil, role: nil}

    test "list_members/0 returns all members" do
      member = member_fixture()
      assert Portals.list_members() == [member]
    end

    test "get_member!/1 returns the member with given id" do
      member = member_fixture()
      assert Portals.get_member!(member.id) == member
    end

    test "create_member/1 with valid data creates a member" do
      valid_attrs = %{fields: %{}, role: "some role"}

      assert {:ok, %Member{} = member} = Portals.create_member(valid_attrs)
      assert member.fields == %{}
      assert member.role == "some role"
    end

    test "create_member/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portals.create_member(@invalid_attrs)
    end

    test "update_member/2 with valid data updates the member" do
      member = member_fixture()
      update_attrs = %{fields: %{}, role: "some updated role"}

      assert {:ok, %Member{} = member} = Portals.update_member(member, update_attrs)
      assert member.fields == %{}
      assert member.role == "some updated role"
    end

    test "update_member/2 with invalid data returns error changeset" do
      member = member_fixture()
      assert {:error, %Ecto.Changeset{}} = Portals.update_member(member, @invalid_attrs)
      assert member == Portals.get_member!(member.id)
    end

    test "delete_member/1 deletes the member" do
      member = member_fixture()
      assert {:ok, %Member{}} = Portals.delete_member(member)
      assert_raise Ecto.NoResultsError, fn -> Portals.get_member!(member.id) end
    end

    test "change_member/1 returns a member changeset" do
      member = member_fixture()
      assert %Ecto.Changeset{} = Portals.change_member(member)
    end
  end

  describe "permissions" do
    alias Studio.Portals.Permission

    import Studio.PortalsFixtures

    @invalid_attrs %{scope: nil, action: nil, criteria: nil}

    test "list_permissions/0 returns all permissions" do
      permission = permission_fixture()
      assert Portals.list_permissions() == [permission]
    end

    test "get_permission!/1 returns the permission with given id" do
      permission = permission_fixture()
      assert Portals.get_permission!(permission.id) == permission
    end

    test "create_permission/1 with valid data creates a permission" do
      valid_attrs = %{scope: "some scope", action: "some action", criteria: "some criteria"}

      assert {:ok, %Permission{} = permission} = Portals.create_permission(valid_attrs)
      assert permission.scope == "some scope"
      assert permission.action == "some action"
      assert permission.criteria == "some criteria"
    end

    test "create_permission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portals.create_permission(@invalid_attrs)
    end

    test "update_permission/2 with valid data updates the permission" do
      permission = permission_fixture()
      update_attrs = %{scope: "some updated scope", action: "some updated action", criteria: "some updated criteria"}

      assert {:ok, %Permission{} = permission} = Portals.update_permission(permission, update_attrs)
      assert permission.scope == "some updated scope"
      assert permission.action == "some updated action"
      assert permission.criteria == "some updated criteria"
    end

    test "update_permission/2 with invalid data returns error changeset" do
      permission = permission_fixture()
      assert {:error, %Ecto.Changeset{}} = Portals.update_permission(permission, @invalid_attrs)
      assert permission == Portals.get_permission!(permission.id)
    end

    test "delete_permission/1 deletes the permission" do
      permission = permission_fixture()
      assert {:ok, %Permission{}} = Portals.delete_permission(permission)
      assert_raise Ecto.NoResultsError, fn -> Portals.get_permission!(permission.id) end
    end

    test "change_permission/1 returns a permission changeset" do
      permission = permission_fixture()
      assert %Ecto.Changeset{} = Portals.change_permission(permission)
    end
  end

  describe "posts" do
    alias Studio.Portals.Post

    import Studio.PortalsFixtures

    @invalid_attrs %{data: nil, id: nil, type: nil, fields: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Portals.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Portals.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{data: %{}, id: "7488a646-e31f-11e4-aace-600308960662", type: "some type", fields: %{}}

      assert {:ok, %Post{} = post} = Portals.create_post(valid_attrs)
      assert post.data == %{}
      assert post.id == "7488a646-e31f-11e4-aace-600308960662"
      assert post.type == "some type"
      assert post.fields == %{}
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portals.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{data: %{}, id: "7488a646-e31f-11e4-aace-600308960668", type: "some updated type", fields: %{}}

      assert {:ok, %Post{} = post} = Portals.update_post(post, update_attrs)
      assert post.data == %{}
      assert post.id == "7488a646-e31f-11e4-aace-600308960668"
      assert post.type == "some updated type"
      assert post.fields == %{}
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Portals.update_post(post, @invalid_attrs)
      assert post == Portals.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Portals.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Portals.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Portals.change_post(post)
    end
  end
end
