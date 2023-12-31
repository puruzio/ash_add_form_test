defmodule AshAddFormTest.Repo.Migrations.CreateResources do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:tasks, primary_key: false) do
      add :id, :uuid, null: false, primary_key: true
      add :task_name, :text, null: false
      add :task_number, :bigserial
      add :task_code, :text
      add :description, :text
      add :detail_description, :text
      add :inserted_at, :utc_datetime_usec, null: false, default: fragment("now()")
      add :updated_at, :utc_datetime_usec, null: false, default: fragment("now()")
    end

    create table(:task_members, primary_key: false) do
      add :id, :uuid, null: false, primary_key: true
      add :member_type, :bigint, null: false, default: 1
      add :row_order, :bigint, null: false, default: 0
      add :email, :text, null: false
      add :inserted_at, :utc_datetime_usec, null: false, default: fragment("now()")
      add :updated_at, :utc_datetime_usec, null: false, default: fragment("now()")

      add :task_id,
          references(:tasks,
            column: :id,
            name: "task_members_task_id_fkey",
            type: :uuid,
            on_delete: :delete_all
          ),
          null: false
    end

    create unique_index(:task_members, [:task_id, :email],
             name: "task_members_unique_task_and_member_index"
           )
  end

  def down do
    drop_if_exists unique_index(:task_members, [:task_id, :email],
                     name: "task_members_unique_task_and_member_index"
                   )

    drop constraint(:task_members, "task_members_task_id_fkey")

    drop table(:task_members)

    drop table(:tasks)
  end
end