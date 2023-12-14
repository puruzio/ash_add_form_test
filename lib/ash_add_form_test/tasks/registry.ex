defmodule AshAddFormTest.Tasks.Registry do
  use Ash.Registry

  entries do
    entry(AshAddFormTest.Tasks.Task)
    entry(AshAddFormTest.Tasks.Comment)

    # entry Taskcalendars.Accounts.User
    entry(AshAddFormTest.Accounts.TaskMember)
  end
end
