defmodule AshAddFormTest.Tasks.Comment do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  require Ecto.Query

  actions do
    defaults([:read, :destroy])

    create :create do
      primary?(true)
    end

    update :update do
      primary?(true)
    end
  end

  code_interface do
    define_for(AshAddFormTest.Tasks)
    define(:create)
  end

  attributes do
    uuid_primary_key(:id)

    attribute :text, :string do
      allow_nil?(true)
    end

    timestamps()
  end

  postgres do
    table("comments")
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
