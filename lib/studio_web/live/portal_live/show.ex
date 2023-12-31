defmodule StudioWeb.PortalLive.Show do
  use StudioWeb, :live_view

  alias Studio.Portals

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:portal, Portals.get_portal!(id))}
  end

  defp page_title(:show), do: "Show Portal"
  defp page_title(:edit), do: "Edit Portal"
end
