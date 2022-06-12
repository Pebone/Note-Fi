defmodule Av3.Repo.Migrations.CreateRevenue do
  use Ecto.Migration

  def change do
    create table(:revenue) do
      add :user_id, :string
      add :type, :string
      add :value, :string

      timestamps()
    end
  end
end
