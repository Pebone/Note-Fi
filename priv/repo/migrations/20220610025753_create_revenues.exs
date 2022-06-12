defmodule Av3.Repo.Migrations.CreateRevenues do
  use Ecto.Migration

  def change do
    create table(:revenues) do
      add :type, :string
      add :value, :string

      timestamps()
    end
  end
end
