defmodule StudioWeb.PermissionLiveTest do
  use StudioWeb.ConnCase

  import Phoenix.LiveViewTest
  import Studio.PortalsFixtures

  @create_attrs %{scope: "some scope", action: "some action", criteria: "some criteria"}
  @update_attrs %{scope: "some updated scope", action: "some updated action", criteria: "some updated criteria"}
  @invalid_attrs %{scope: nil, action: nil, criteria: nil}

  defp create_permission(_) do
    permission = permission_fixture()
    %{permission: permission}
  end

  describe "Index" do
    setup [:create_permission]

    test "lists all permissions", %{conn: conn, permission: permission} do
      {:ok, _index_live, html} = live(conn, ~p"/permissions")

      assert html =~ "Listing Permissions"
      assert html =~ permission.scope
    end

    test "saves new permission", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/permissions")

      assert index_live |> element("a", "New Permission") |> render_click() =~
               "New Permission"

      assert_patch(index_live, ~p"/permissions/new")

      assert index_live
             |> form("#permission-form", permission: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#permission-form", permission: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/permissions")

      html = render(index_live)
      assert html =~ "Permission created successfully"
      assert html =~ "some scope"
    end

    test "updates permission in listing", %{conn: conn, permission: permission} do
      {:ok, index_live, _html} = live(conn, ~p"/permissions")

      assert index_live |> element("#permissions-#{permission.id} a", "Edit") |> render_click() =~
               "Edit Permission"

      assert_patch(index_live, ~p"/permissions/#{permission}/edit")

      assert index_live
             |> form("#permission-form", permission: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#permission-form", permission: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/permissions")

      html = render(index_live)
      assert html =~ "Permission updated successfully"
      assert html =~ "some updated scope"
    end

    test "deletes permission in listing", %{conn: conn, permission: permission} do
      {:ok, index_live, _html} = live(conn, ~p"/permissions")

      assert index_live |> element("#permissions-#{permission.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#permissions-#{permission.id}")
    end
  end

  describe "Show" do
    setup [:create_permission]

    test "displays permission", %{conn: conn, permission: permission} do
      {:ok, _show_live, html} = live(conn, ~p"/permissions/#{permission}")

      assert html =~ "Show Permission"
      assert html =~ permission.scope
    end

    test "updates permission within modal", %{conn: conn, permission: permission} do
      {:ok, show_live, _html} = live(conn, ~p"/permissions/#{permission}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Permission"

      assert_patch(show_live, ~p"/permissions/#{permission}/show/edit")

      assert show_live
             |> form("#permission-form", permission: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#permission-form", permission: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/permissions/#{permission}")

      html = render(show_live)
      assert html =~ "Permission updated successfully"
      assert html =~ "some updated scope"
    end
  end
end
