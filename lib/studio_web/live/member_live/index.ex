defmodule StudioWeb.MemberLive.Index do
  use StudioWeb, :live_view

  alias Studio.Portals
  alias Studio.Portals.Member

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :members, Portals.list_members())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Member")
    |> assign(:member, Portals.get_member!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Member")
    |> assign(:member, %Member{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Members")
    |> assign(:member, nil)
  end

  @impl true
  def handle_info({StudioWeb.MemberLive.FormComponent, {:saved, member}}, socket) do
    {:noreply, stream_insert(socket, :members, member)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    member = Portals.get_member!(id)
    {:ok, _} = Portals.delete_member(member)

    {:noreply, stream_delete(socket, :members, member)}
  end
end
