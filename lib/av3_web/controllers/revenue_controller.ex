defmodule Av3Web.RevenueController do

  use Av3Web, :controller

  alias Av3.Repo
  alias Av3.Revenue

  def index(conn, _params) do
    revenue = Repo.all(Revenue)
    render(conn, "index.html", revenue: revenue)
  end

  def new(conn, _params) do
    changeset = Revenue.changeset(%Revenue{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"revenue" => revenue}) do
    changeset = Revenue.changeset(%Revenue{}, revenue)
    case Repo.insert(changeset) do
      {:ok, revenue} ->
        conn
        |> put_flash(:info, "Receita #{revenue.type} cadastrada com sucesso.")
        |> redirect(to: Routes.revenue_path(conn, :index))
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
    revenue = Repo.get(Revenue, inteiro)
    changeset = Revenue.changeset(revenue, %{})
    render(conn, "edit.html", revenue_id: revenue.id, changeset: changeset)
  end

  def update(conn, %{"id" => id, "revenue" => revenue}) do
    rev = Repo.get(Revenue, id)
    changeset = Revenue.changeset(rev, revenue)
    {:ok, revenue} = Repo.update(changeset)

    conn
    |> put_flash(:info, "Receita #{revenue.type} alterada com sucesso!")
    |> redirect(to: Routes.revenue_path(conn, :index))
  end

  def delete_revenue(%Revenue{} = revenue) do
    Repo.delete(revenue)
  end

  def get_revenue!(id), do: Repo.get!(Revenue, id)

  def delete(conn, %{"id" => id}) do
    revenue = get_revenue!(id)
    {:ok, revenue} = delete_revenue(revenue)

    conn
    |> put_flash(:info, "Receita #{revenue.type} deletada com sucesso.")
    |> redirect(to: Routes.revenue_path(conn, :index))
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
