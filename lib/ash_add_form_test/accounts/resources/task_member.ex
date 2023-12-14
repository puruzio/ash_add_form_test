defmodule AshAddFormTest.Accounts.TaskMember do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  require Ecto.Query

  actions do
    defaults([:read, :destroy])

    read :read_members do
      argument :task_id, :uuid do
        allow_nil?(false)
      end

      prepare(build(sort: [inserted_at: :desc]))
    end

    create :create do
      primary?(true)
    end

    create :create_member do
      argument :email, :string do
        allow_nil?(false)
      end

      argument :task_id, :uuid do
        allow_nil?(false)
      end

      argument :member_type, :uuid do
        allow_nil?(false)
      end

      change(set_attribute(:email, arg(:email)))
      change(set_attribute(:task_id, arg(:task_id)))
    end

    update :update do
      primary?(true)
    end
  end

  identities do
    identity(:unique_task_and_member, [:task_id, :email])
  end

  code_interface do
    define_for(AshAddFormTest.Accounts)
    define(:read_members, args: [:task_id])
    define(:create_member, args: [:email, :task_id, :member_type])
    define(:get, action: :read, get_by: [:id])
    define(:destroy)
    define(:create)
  end

  attributes do
    uuid_primary_key(:id)

    attribute :member_type, :integer do
      allow_nil?(false)
      default(1)
    end

    attribute :row_order, :integer do
      allow_nil?(false)
      default(0)
    end

    attribute :email, :string do
      allow_nil?(false)
    end

    timestamps()
  end

  postgres do
    table("task_members")
    repo(AshAddFormTest.Repo)

    references do
      reference(:task, on_delete: :delete)
    end
  end

  relationships do
    belongs_to :task, AshAddFormTest.Tasks.Task do
      api(AshAddFormTest.Tasks)
      allow_nil?(false)
      attribute_writable?(true)
    end
  end
end
