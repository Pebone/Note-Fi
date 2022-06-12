defmodule Av3Web.ExpenseController do

  use Av3Web, :controller

  alias Av3.Repo
  alias Av3.Expense

  def index(conn, _params) do
    expense = Repo.all(Expense)
    render(conn, "index.html", expense: expense)
  end

  def new(conn, _params) do
    changeset = Expense.changeset(%Expense{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"expense" => expense}) do
    changeset = Expense.changeset(%Expense{}, expense)
    case Repo.insert(changeset) do
      {:ok, expense} ->
        conn
        |> put_flash(:info, "Despesa #{expense.type} cadastrada com sucesso.")
        |> redirect(to: Routes.expense_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        changeset = %{changeset | action: :check_errors}
        render(conn, "new.html", changeset: changeset)
    end
  end

  # def edit(conn, _params) do
  #   changeset = Expense.changeset(%Expense{}, %{})
  #   render(conn, "edit.html", changeset: changeset)
  # end

  def edit(conn, %{"id" => id}) do
    inteiro = String.to_integer(id)
    expense = Repo.get(Expense, inteiro)
    changeset = Expense.changeset(expense, %{})
    render(conn, "edit.html", expense_id: expense.id, changeset: changeset)
  end

  def update(conn, %{"id" => id, "expense" => expense}) do
    exp = Repo.get(Expense, id)
    changeset = Expense.changeset(exp, expense)
    {:ok, _expense} = Repo.update(changeset)

    conn
    |> put_flash(:info, "Despesa alterada com sucesso!")
    |> redirect(to: Routes.expense_path(conn, :index))
  end

  def delete_expense(%Expense{} = expense) do
    Repo.delete(expense)
  end

  def get_expense!(id), do: Repo.get!(Expense, id)

  def delete(conn, %{"id" => id}) do
    expense = get_expense!(id)
    {:ok, _expense} = delete_expense(expense)

    conn
    |> put_flash(:info, "Banks deleted successfully.")
    |> redirect(to: Routes.expense_path(conn, :index))
  end

  # def update(conn, %{"expense" => expense}) do
  #   changeset = Expense.changeset(%Expense{}, expense)
  #   case Repo.insert(changeset) do
  #     {:ok, expense} ->
  #       conn
  #       |> put_flash(:info, "Despesa #{expense.type} editada com sucesso.")
  #       |> redirect(to: Routes.expense_path(conn, :index))
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       changeset = %{changeset | action: :check_errors}
  #       render(conn, "edit.html", changeset: changeset)
  #   end
  # end

end
