defmodule StudioWeb.PermissionLive.FormComponent do
  use StudioWeb, :live_component

  alias Studio.Portals

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage permission records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="permission-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:scope]} type="text" label="Scope" />
        <.input field={@form[:action]} type="text" label="Action" />
        <.input field={@form[:criteria]} type="text" label="Criteria" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Permission</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{permission: permission} = assigns, socket) do
    changeset = Portals.change_permission(permission)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"permission" => permission_params}, socket) do
    changeset =
      socket.assigns.permission
      |> Portals.change_permission(permission_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"permission" => permission_params}, socket) do
    save_permission(socket, socket.assigns.action, permission_params)
  end

  defp save_permission(socket, :edit, permission_params) do
    case Portals.update_permission(socket.assigns.permission, permission_params) do
      {:ok, permission} ->
        notify_parent({:saved, permission})

        {:noreply,
         socket
         |> put_flash(:info, "Permission updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_permission(socket, :new, permission_params) do
    case Portals.create_permission(permission_params) do
      {:ok, permission} ->
        notify_parent({:saved, permission})

        {:noreply,
         socket
         |> put_flash(:info, "Permission created successfully")
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
