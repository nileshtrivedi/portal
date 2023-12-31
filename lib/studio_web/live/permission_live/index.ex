defmodule StudioWeb.PermissionLive.Index do
  use StudioWeb, :live_view

  alias Studio.Portals
  alias Studio.Portals.Permission

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :permissions, Portals.list_permissions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Permission")
    |> assign(:permission, Portals.get_permission!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Permission")
    |> assign(:permission, %Permission{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Permissions")
    |> assign(:permission, nil)
  end

  @impl true
  def handle_info({StudioWeb.PermissionLive.FormComponent, {:saved, permission}}, socket) do
    {:noreply, stream_insert(socket, :permissions, permission)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    permission = Portals.get_permission!(id)
    {:ok, _} = Portals.delete_permission(permission)

    {:noreply, stream_delete(socket, :permissions, permission)}
  end
end
