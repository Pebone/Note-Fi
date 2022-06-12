defmodule Av3.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :password, :string
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :password, :password_confirmation])
    |> validate_required([:name, :password, :password_confirmation])
    |> validate_confirmation(:password)
  end
end
