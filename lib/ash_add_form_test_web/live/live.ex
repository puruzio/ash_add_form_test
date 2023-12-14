defmodule AshAddFormTestWeb.TaskLive.Edit do
  use AshAddFormTestWeb, :live_view

  alias AshAddFormTest.Tasks.{Task}
  alias AshAddFormTest.Tasks
  alias AshAddFormTest.Accounts.{TaskMember}
  alias AshAddFormTest.Accounts

  import Phoenix.HTML.Form
  require Ash.Query

  @impl true
  def render(assigns) do
    ~H"""
    <div
      :if={@live_action not in [:edit_delete_modal]}
      class="relative flex flex-col justify-items-center md:w-3/4 "
    >
      <div class="w-full md:max-w-3xl flex flex-col">
        <.form :let={f} for={@form} phx-change="validate" phx-submit="save" class="mt-5">
          <section
            :if={@live_action in [:new, :new_with_date, :edit_event]}
            id="event_section"
            class="space-y-5"
          >
            <div class="grid grid-columns-2 grid-flow-col gap-10">
              <div>
                <.input
                  field={{f, :task_name}}
                  type="text"
                  label="Task Name *"
                  placeholder="Your task name here.."
                  required
                />
              </div>
            </div>

            <div class="my-8 space-y-2">
              <label class="flex items-center gap-4 text-sm leading-6 font-semibold leading-6 block text-zinc-900">
                Task Owner Emails*
              </label>
              <%= for task_member_form <- inputs_for(f, :task_members) do %>
                <div class="flex flex-row relative px-3 pb-3  rounded-md bg-gray-100 space-x-5">
                  <.task_member_input_simple task_member_form={task_member_form} />
                </div>
              <% end %>
            </div>

            <div class="flex justify-center">
              <button
                type="button"
                phx-click="add_task_member"
                class="p-4 bg-gray-500 hover:bg-gray-700 rounded-full "
              >
                <div class="text-white"><.svg_plus /></div>
              </button>
            </div>
          </section>

          <section id="confirm" class="mt-20">
            <div class="flex flex-row mt-2 xs:mt-0 space-x-5 items-center justify-between ">
              <div class="flex flex-row mt-2 space-x-2">
                <div :if={@live_action not in [:new, :new_with_date]}>
                  <a href={~p"/tasks/#{@task.id}/task_edit_delete_modal"}>
                    <.button
                      type="button"
                      class=" bg-red-900 hover:bg-red-700"
                      phx-value-task_id={@task.id}
                    >
                      Delete Task
                    </.button>
                  </a>
                </div>

                <div class="w-25">
                  <a href={~p"/tasks/dashboard"}>
                    <.button type="button" class="bg-zinc-700">
                      Cancel
                    </.button>
                  </a>
                </div>
              </div>

              <div class="inline-flex mt-2 xs:mt-0 space-x-3">
                <.button
                  :if={@live_action not in [:new, :new_with_date, :edit_event]}
                  type="button"
                  phx-click={JS.push("prev") |> JS.push("save")}
                  class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-gray-800 rounded-r hover:bg-gray-900 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                >
                  <svg
                    aria-hidden="true"
                    class="w-5 h-5 mr-2"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      fill-rule="evenodd"
                      d="M7.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l2.293 2.293a1 1 0 010 1.414z"
                      clip-rule="evenodd"
                    >
                    </path>
                  </svg>
                  Prev
                </.button>

                <.button
                  phx-disable-with="Saving info..."
                  class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-gray-800 border-0 border-l border-gray-700 rounded-l hover:bg-gray-900 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
                >
                  <%= if @live_action  in [ :new, :new_with_date, :edit_event, :edit_keydates] do %>
                    Save and Continue
                    <svg
                      aria-hidden="true"
                      class="w-5 h-5 ml-2"
                      fill="currentColor"
                      viewBox="0 0 20 20"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        fill-rule="evenodd"
                        d="M12.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-2.293-2.293a1 1 0 010-1.414z"
                        clip-rule="evenodd"
                      >
                      </path>
                    </svg>
                  <% else %>
                    Save and Exit
                  <% end %>
                </.button>
              </div>
            </div>
          </section>
        </.form>
      </div>
    </div>
    """
  end

  def svg_plus(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      stroke-width="1.5"
      stroke="currentColor"
      class="w-6 h-6"
    >
      <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
    </svg>
    """
  end

  def task_member_input_simple(assigns) do
    ~H"""
    <div class="relative pt-1 space-y-1 w-full">
      <div class="grid grid-columns-2 grid-flow-col gap-4">
        <div class="w-48">
          <.input field={{@task_member_form, :email}} type="text" label="" />
        </div>

        <div class="w-28">
          <.input
            field={{@task_member_form, :member_type}}
            type="select-simple"
            label="TaskMember Type"
            options={[assignee: 1, viewer: 8, approver: 6, admin: 7]}
          />
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    socket1 =
      socket
      |> assign_tasks()

    {:ok, socket1}
  end

  defp assign_tasks(socket) do
    tasks =
      Task.read!(load: task_load())

    assign(socket, tasks: tasks)
  end

  @impl true
  def handle_params(params, _url, socket) do
    action = socket.assigns.live_action

    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    apply_action_new_common(socket)
  end

  defp apply_action_new_common(socket) do
    form =
      AshPhoenix.Form.for_create(Task, :create,
        api: AshAddFormTest.Tasks,
        # actor: "me",
        forms: [
          auto?: true,
          task_members: [
            resource: TaskMember,
            data: [%TaskMember{}],
            create_action: :create,
            update_action: :update,
            type: :list
          ]
        ]
      )

    socket
    |> assign(:form, form)
  end

  def task_load() do
    [
      :task_members
    ]
  end

  @impl true
  def handle_event("validate", %{"form" => form_params}, socket) do
    IO.inspect(form_params, label: "validate form_params =#################")
    task_key_value_entered = form_params |> Map.get("task_code", nil)

    form =
      AshPhoenix.Form.validate(socket.assigns.form, form_params)
      |> IO.inspect(label: "validate form =#################")

    {
      :noreply,
      socket
      |> assign(form: form)
    }
  end

  def handle_event("save", _, socket) do
    output = AshPhoenix.Form.submit(socket.assigns.form)

    {
      :noreply,
      socket
      |> assign(is_adding_form: false)
      |> assign(submitted_by_prev_button: false)
    }
  end

  def handle_event("add_task_member", _params, socket) do
    # Logger.debug(inspect(socket.assigns.form, pretty: true))
    form = AshPhoenix.Form.add_form(socket.assigns.form, :task_members)
    # {:noreply, assign(socket, :form, form)}

    task_member_list = form.forms.task_members

    task_member_list =
      task_member_list
      |> Enum.with_index()
      |> Enum.map(fn {form, index} ->
        form_param = Map.put(form.params, :row_order, index)
        AshPhoenix.Form.validate(form, form_param)
      end)

    new_form = %{
      socket.assigns.form
      | forms: %{socket.assigns.form.forms | task_members: task_member_list}
    }

    {:noreply,
     socket
     |> assign(form: new_form)
     |> assign(:is_adding_form, true)}
  end

  def handle_event("remove_task_member_form", %{"path" => path}, socket) do
    form = AshPhoenix.Form.remove_form(socket.assigns.form, path)
    {:noreply, assign(socket, :form, form)}
  end
end
