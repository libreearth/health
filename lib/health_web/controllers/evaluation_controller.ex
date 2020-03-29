defmodule HealthWeb.EvaluationController do
  use HealthWeb, :controller

  alias Health.Evaluations
  alias Health.Evaluations.Evaluation

  def index(conn, _params) do
    evaluations = Evaluations.list_evaluations()
    render(conn, "index.html", evaluations: evaluations)
  end

  def new(conn, _params) do
    changeset = Evaluations.change_evaluation(%Evaluation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"evaluation" => evaluation_params}) do
    IO.inspect evaluation_params
    case Evaluations.create_evaluation(evaluation_params) do
      {:ok, evaluation} ->
        conn
        |> put_flash(:info, "Evaluation created successfully.")
        |> redirect(to: Routes.evaluation_path(conn, :show, evaluation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    evaluation = Evaluations.get_evaluation!(id)
    render(conn, "show.html", evaluation: evaluation)
  end

  def edit(conn, %{"id" => id}) do
    evaluation = Evaluations.get_evaluation!(id)
    changeset = Evaluations.change_evaluation(evaluation)
    render(conn, "edit.html", evaluation: evaluation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "evaluation" => evaluation_params}) do
    evaluation = Evaluations.get_evaluation!(id)

    case Evaluations.update_evaluation(evaluation, evaluation_params) do
      {:ok, evaluation} ->
        conn
        |> put_flash(:info, "Evaluation updated successfully.")
        |> redirect(to: Routes.evaluation_path(conn, :show, evaluation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", evaluation: evaluation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    evaluation = Evaluations.get_evaluation!(id)
    {:ok, _evaluation} = Evaluations.delete_evaluation(evaluation)

    conn
    |> put_flash(:info, "Evaluation deleted successfully.")
    |> redirect(to: Routes.evaluation_path(conn, :index))
  end
end
