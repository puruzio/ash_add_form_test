defmodule AshAddFormTest.Repo do
  use Ecto.Repo,
    otp_app: :ash_add_form_test,
    adapter: Ecto.Adapters.Postgres

  def installed_extensions do
    ["citext", "uuid-ossp", "ash-functions"]
  end
end
