defmodule Av3.Repo.Migrations.CreateExpense do
  use Ecto.Migration

  def change do
    create table(:expense) do
      add :type, :string
      add :value, :string

      timestamps()
    end
  end
end
