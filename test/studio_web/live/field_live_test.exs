defmodule StudioWeb.FieldLiveTest do
  use StudioWeb.ConnCase

  import Phoenix.LiveViewTest
  import Studio.PortalsFixtures

  @create_attrs %{name: "some name", scope: "some scope", type: "some type", is_required: true}
  @update_attrs %{name: "some updated name", scope: "some updated scope", type: "some updated type", is_required: false}
  @invalid_attrs %{name: nil, scope: nil, type: nil, is_required: false}

  defp create_field(_) do
    field = field_fixture()
    %{field: field}
  end

  describe "Index" do
    setup [:create_field]

    test "lists all fields", %{conn: conn, field: field} do
      {:ok, _index_live, html} = live(conn, ~p"/fields")

      assert html =~ "Listing Fields"
      assert html =~ field.name
    end

    test "saves new field", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/fields")

      assert index_live |> element("a", "New Field") |> render_click() =~
               "New Field"

      assert_patch(index_live, ~p"/fields/new")

      assert index_live
             |> form("#field-form", field: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#field-form", field: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fields")

      html = render(index_live)
      assert html =~ "Field created successfully"
      assert html =~ "some name"
    end

    test "updates field in listing", %{conn: conn, field: field} do
      {:ok, index_live, _html} = live(conn, ~p"/fields")

      assert index_live |> element("#fields-#{field.id} a", "Edit") |> render_click() =~
               "Edit Field"

      assert_patch(index_live, ~p"/fields/#{field}/edit")

      assert index_live
             |> form("#field-form", field: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#field-form", field: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fields")

      html = render(index_live)
      assert html =~ "Field updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes field in listing", %{conn: conn, field: field} do
      {:ok, index_live, _html} = live(conn, ~p"/fields")

      assert index_live |> element("#fields-#{field.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#fields-#{field.id}")
    end
  end

  describe "Show" do
    setup [:create_field]

    test "displays field", %{conn: conn, field: field} do
      {:ok, _show_live, html} = live(conn, ~p"/fields/#{field}")

      assert html =~ "Show Field"
      assert html =~ field.name
    end

    test "updates field within modal", %{conn: conn, field: field} do
      {:ok, show_live, _html} = live(conn, ~p"/fields/#{field}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Field"

      assert_patch(show_live, ~p"/fields/#{field}/show/edit")

      assert show_live
             |> form("#field-form", field: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#field-form", field: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/fields/#{field}")

      html = render(show_live)
      assert html =~ "Field updated successfully"
      assert html =~ "some updated name"
    end
  end
end
