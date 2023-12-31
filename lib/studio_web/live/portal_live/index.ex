defmodule StudioWeb.PortalLive.Index do
  use StudioWeb, :live_view

  alias Studio.Portals
  alias Studio.Portals.Portal

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :portals, Portals.list_portals())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Portal")
    |> assign(:portal, Portals.get_portal!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Portal")
    |> assign(:portal, %Portal{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Portals")
    |> assign(:portal, nil)
  end

  @impl true
  def handle_info({StudioWeb.PortalLive.FormComponent, {:saved, portal}}, socket) do
    {:noreply, stream_insert(socket, :portals, portal)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    portal = Portals.get_portal!(id)
    {:ok, _} = Portals.delete_portal(portal)

    {:noreply, stream_delete(socket, :portals, portal)}
  end
end
