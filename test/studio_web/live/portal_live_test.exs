defmodule StudioWeb.PortalLiveTest do
  use StudioWeb.ConnCase

  import Phoenix.LiveViewTest
  import Studio.PortalsFixtures

  @create_attrs %{id: "7488a646-e31f-11e4-aace-600308960662", type: "some type", fields: %{}, display_name: "some display_name", slug: "some slug"}
  @update_attrs %{id: "7488a646-e31f-11e4-aace-600308960668", type: "some updated type", fields: %{}, display_name: "some updated display_name", slug: "some updated slug"}
  @invalid_attrs %{id: nil, type: nil, fields: nil, display_name: nil, slug: nil}

  defp create_portal(_) do
    portal = portal_fixture()
    %{portal: portal}
  end

  describe "Index" do
    setup [:create_portal]

    test "lists all portals", %{conn: conn, portal: portal} do
      {:ok, _index_live, html} = live(conn, ~p"/portals")

      assert html =~ "Listing Portals"
      assert html =~ portal.type
    end

    test "saves new portal", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/portals")

      assert index_live |> element("a", "New Portal") |> render_click() =~
               "New Portal"

      assert_patch(index_live, ~p"/portals/new")

      assert index_live
             |> form("#portal-form", portal: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#portal-form", portal: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/portals")

      html = render(index_live)
      assert html =~ "Portal created successfully"
      assert html =~ "some type"
    end

    test "updates portal in listing", %{conn: conn, portal: portal} do
      {:ok, index_live, _html} = live(conn, ~p"/portals")

      assert index_live |> element("#portals-#{portal.id} a", "Edit") |> render_click() =~
               "Edit Portal"

      assert_patch(index_live, ~p"/portals/#{portal}/edit")

      assert index_live
             |> form("#portal-form", portal: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#portal-form", portal: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/portals")

      html = render(index_live)
      assert html =~ "Portal updated successfully"
      assert html =~ "some updated type"
    end

    test "deletes portal in listing", %{conn: conn, portal: portal} do
      {:ok, index_live, _html} = live(conn, ~p"/portals")

      assert index_live |> element("#portals-#{portal.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#portals-#{portal.id}")
    end
  end

  describe "Show" do
    setup [:create_portal]

    test "displays portal", %{conn: conn, portal: portal} do
      {:ok, _show_live, html} = live(conn, ~p"/portals/#{portal}")

      assert html =~ "Show Portal"
      assert html =~ portal.type
    end

    test "updates portal within modal", %{conn: conn, portal: portal} do
      {:ok, show_live, _html} = live(conn, ~p"/portals/#{portal}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Portal"

      assert_patch(show_live, ~p"/portals/#{portal}/show/edit")

      assert show_live
             |> form("#portal-form", portal: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#portal-form", portal: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/portals/#{portal}")

      html = render(show_live)
      assert html =~ "Portal updated successfully"
      assert html =~ "some updated type"
    end
  end
end
