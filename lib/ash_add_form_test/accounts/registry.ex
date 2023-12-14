defmodule AshAddFormTest.Accounts.Registry do
  use Ash.Registry,
    extensions: Ash.Registry.ResourceValidations

  entries do
    entry(AshAddFormTest.Accounts.TaskMember)
  end
end
