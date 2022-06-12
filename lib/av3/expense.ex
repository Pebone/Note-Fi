defmodule Av3.Expense do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expense" do
    field :type, :string
    field :user_id, :string
    field :value, :string

    timestamps()
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:user_id, :type, :value])
    |> validate_required([:user_id, :type, :value])
  end
end
