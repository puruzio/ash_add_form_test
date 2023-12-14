defmodule AshAddFormTestWeb.ErrorJSONTest do
  use AshAddFormTestWeb.ConnCase, async: true

  test "renders 404" do
    assert AshAddFormTestWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert AshAddFormTestWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
