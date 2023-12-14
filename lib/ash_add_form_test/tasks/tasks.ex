defmodule AshAddFormTest.Tasks do
  use Ash.Api
  # extensions: [AshAdmin.Api]

  # admin do
  #   show?(true)
  # end

  resources do
    registry(AshAddFormTest.Tasks.Registry)
  end

  ## This make policies in all resource take effect.
  authorization do
    authorize(:by_default)
  end
end
