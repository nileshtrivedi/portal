defmodule StudioWeb.FieldLive.Index do
  use StudioWeb, :live_view

  alias Studio.Portals
  alias Studio.Portals.Field

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :fields, Portals.list_fields())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Field")
    |> assign(:field, Portals.get_field!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Field")
    |> assign(:field, %Field{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Fields")
    |> assign(:field, nil)
  end

  @impl true
  def handle_info({StudioWeb.FieldLive.FormComponent, {:saved, field}}, socket) do
    {:noreply, stream_insert(socket, :fields, field)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    field = Portals.get_field!(id)
    {:ok, _} = Portals.delete_field(field)

    {:noreply, stream_delete(socket, :fields, field)}
  end
end
