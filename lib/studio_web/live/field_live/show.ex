defmodule StudioWeb.FieldLive.Show do
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
     |> assign(:field, Portals.get_field!(id))}
  end

  defp page_title(:show), do: "Show Field"
  defp page_title(:edit), do: "Edit Field"
end
