defmodule AshAddFormTest.Repo.Migrations.CreateComment do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    # alter table(:tasks) do
    # Attribute removal has been commented out to avoid data loss. See the migration generator documentation for more
    # If you uncomment this, be sure to also uncomment the corresponding attribute *addition* in the `down` migration
    # remove :detail_description
    # 
    # Attribute removal has been commented out to avoid data loss. See the migration generator documentation for more
    # If you uncomment this, be sure to also uncomment the corresponding attribute *addition* in the `down` migration
    # remove :description
    # 
    # Attribute removal has been commented out to avoid data loss. See the migration generator documentation for more
    # If you uncomment this, be sure to also uncomment the corresponding attribute *addition* in the `down` migration
    # remove :task_code
    # 
    # Attribute removal has been commented out to avoid data loss. See the migration generator documentation for more
    # If you uncomment this, be sure to also uncomment the corresponding attribute *addition* in the `down` migration
    # remove :task_number
    # end
    # 
  end

  def down do
    # alter table(:tasks) do
    # This is the `down` migration of the statement:
    #
    #     remove :task_number
    #
    # 
    # add :task_number, :bigserial
    # This is the `down` migration of the statement:
    #
    #     remove :task_code
    #
    # 
    # add :task_code, :text
    # This is the `down` migration of the statement:
    #
    #     remove :description
    #
    # 
    # add :description, :text
    # This is the `down` migration of the statement:
    #
    #     remove :detail_description
    #
    # 
    # add :detail_description, :text
    # end
    # 
  end
end