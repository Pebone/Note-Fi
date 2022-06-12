defmodule Av3.Revenue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "revenue" do
    field :type, :string
    field :user_id, :string
    field :value, :string

    timestamps()
  end

  @doc false
  def changeset(revenue, attrs) do
    revenue
    |> cast(attrs, [:user_id, :type, :value])
    |> validate_required([:user_id, :type, :value])
  end
end
