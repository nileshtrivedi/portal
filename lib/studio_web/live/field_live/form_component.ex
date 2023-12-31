defmodule StudioWeb.FieldLive.FormComponent do
  use StudioWeb, :live_component

  alias Studio.Portals

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage field records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="field-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:scope]} type="text" label="Scope" />
        <.input field={@form[:type]} type="select" label="Type" options={[:foo, :bar, :baz]} />
        <.input field={@form[:is_required]} type="checkbox" label="Is required" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Field</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{field: field} = assigns, socket) do
    changeset = Portals.change_field(field)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"field" => field_params}, socket) do
    changeset =
      socket.assigns.field
      |> Portals.change_field(field_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"field" => field_params}, socket) do
    save_field(socket, socket.assigns.action, field_params)
  end

  defp save_field(socket, :edit, field_params) do
    case Portals.update_field(socket.assigns.field, field_params) do
      {:ok, field} ->
        notify_parent({:saved, field})

        {:noreply,
         socket
         |> put_flash(:info, "Field updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_field(socket, :new, field_params) do
    case Portals.create_field(field_params) do
      {:ok, field} ->
        notify_parent({:saved, field})

        {:noreply,
         socket
         |> put_flash(:info, "Field created successfully")
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
