defmodule Av3.Repo.Migrations.CreateExpense do
  use Ecto.Migration

  def change do
    create table(:expense) do
      add :user_id, :string
      add :type, :string
      add :value, :string

      timestamps()
    end
  end
end
