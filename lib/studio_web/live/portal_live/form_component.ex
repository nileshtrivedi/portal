defmodule StudioWeb.PortalLive.FormComponent do
  use StudioWeb, :live_component

  alias Studio.Portals

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage portal records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="portal-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:display_name]} type="text" label="Display name" />
        <.input
          field={@form[:type]}
          type="select"
          label="Type"
          options={[:chat, :course, :posts, :events, :container, :members]}
        />
        <.input field={@form[:slug]} type="text" label="Slug" />
        <.input
          field={@form[:fields]}
          value={@form[:fields].value |> Jason.encode!(pretty: true)}
          type="textarea"
          label="fields"
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Portal</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{portal: portal} = assigns, socket) do
    changeset = Portals.change_portal(portal)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"portal" => portal_params}, socket) do
    changeset =
      socket.assigns.portal
      |> Portals.change_portal(portal_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"portal" => portal_params}, socket) do
    save_portal(socket, socket.assigns.action, portal_params)
  end

  defp save_portal(socket, :edit, portal_params) do
    case Portals.update_portal(socket.assigns.portal, portal_params) do
      {:ok, portal} ->
        notify_parent({:saved, portal})

        {:noreply,
         socket
         |> put_flash(:info, "Portal updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_portal(socket, :new, portal_params) do
    case Portals.create_portal(portal_params) do
      {:ok, portal} ->
        notify_parent({:saved, portal})

        {:noreply,
         socket
         |> put_flash(:info, "Portal created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
