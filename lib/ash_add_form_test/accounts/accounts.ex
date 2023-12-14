defmodule AshAddFormTest.Accounts do
  use Ash.Api

  resources do
    registry(AshAddFormTest.Accounts.Registry)
  end
end
