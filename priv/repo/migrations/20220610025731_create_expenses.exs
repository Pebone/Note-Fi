defmodule Av3.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :type, :string
      add :value, :string

      timestamps()
    end
  end
end
