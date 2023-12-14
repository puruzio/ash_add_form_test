defmodule AshAddFormTest.Tasks.Task do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  require Ash.Query
  require Ecto.Query
  alias AshAddFormTest.Tasks
  alias AshAddFormTest.Tasks.{Comment}

  alias AshAddFormTest.Accounts
  alias AshAddFormTest.Accounts.{TaskMember}

  actions do
    defaults([:read, :destroy])

    create :create do
      primary?(true)

      argument(:task_members, {:array, :map})
      change(manage_relationship(:task_members, type: :create))
      # argument(:comments, {:array, :map})
      # change(manage_relationship(:comments, type: :create))
    end

    update :update do
      primary?(true)

      change(fn changeset, _ ->
        Ash.Changeset.after_action(changeset, fn changeset, result ->
          TaskMember
          |> Ash.Query.for_read(:read)
          |> Ash.Query.filter(task_id == ^result.id and member_type == 7)
          |> Accounts.read!()
          |> case do
            [] ->
              TaskMember
              |> Ash.Changeset.for_create(
                :create,
                %{
                  member_type: 7,
                  email: "default@email.com",
                  task_id: result.id
                }
              )
              |> Accounts.create!()

            _ ->
              changeset
          end

          {:ok, result}
        end)
      end)

      argument(:task_members, {:array, :map})
      change(manage_relationship(:task_members, type: :direct_control))
    end
  end

  code_interface do
    define_for(AshAddFormTest.Tasks)
    define(:read)
  end

  attributes do
    uuid_primary_key(:id)

    attribute :task_name, :string do
      allow_nil?(false)
    end

    timestamps()
  end

  postgres do
    table("tasks")
    repo(AshAddFormTest.Repo)
  end

  relationships do
    has_many :task_members, TaskMember
    has_many :comments, Comment
  end
end
