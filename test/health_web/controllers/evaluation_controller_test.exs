defmodule HealthWeb.EvaluationControllerTest do
  use HealthWeb.ConnCase

  alias Health.Evaluations

  @create_attrs %{alcohol: 42, date_of_birth: ~D[2010-04-17], do_you_work: 42, h3id: "some h3id", happiness: 42, previous_conditions: 42, previous_contact_with_sick: 42, smoker: 42, sports: 42, symptoms: 42, taking_precautions: 42, travel_to_risk: 42, uuid: "some uuid"}
  @update_attrs %{alcohol: 43, date_of_birth: ~D[2011-05-18], do_you_work: 43, h3id: "some updated h3id", happiness: 43, previous_conditions: 43, previous_contact_with_sick: 43, smoker: 43, sports: 43, symptoms: 43, taking_precautions: 43, travel_to_risk: 43, uuid: "some updated uuid"}
  @invalid_attrs %{alcohol: nil, date_of_birth: nil, do_you_work: nil, h3id: nil, happiness: nil, previous_conditions: nil, previous_contact_with_sick: nil, smoker: nil, sports: nil, symptoms: nil, taking_precautions: nil, travel_to_risk: nil, uuid: nil}

  def fixture(:evaluation) do
    {:ok, evaluation} = Evaluations.create_evaluation(@create_attrs)
    evaluation
  end

  describe "index" do
    test "lists all evaluations", %{conn: conn} do
      conn = get(conn, Routes.evaluation_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Evaluations"
    end
  end

  describe "new evaluation" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.evaluation_path(conn, :new))
      assert html_response(conn, 200) =~ "New Evaluation"
    end
  end

  describe "create evaluation" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.evaluation_path(conn, :create), evaluation: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.evaluation_path(conn, :show, id)

      conn = get(conn, Routes.evaluation_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Evaluation"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.evaluation_path(conn, :create), evaluation: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Evaluation"
    end
  end

  describe "edit evaluation" do
    setup [:create_evaluation]

    test "renders form for editing chosen evaluation", %{conn: conn, evaluation: evaluation} do
      conn = get(conn, Routes.evaluation_path(conn, :edit, evaluation))
      assert html_response(conn, 200) =~ "Edit Evaluation"
    end
  end

  describe "update evaluation" do
    setup [:create_evaluation]

    test "redirects when data is valid", %{conn: conn, evaluation: evaluation} do
      conn = put(conn, Routes.evaluation_path(conn, :update, evaluation), evaluation: @update_attrs)
      assert redirected_to(conn) == Routes.evaluation_path(conn, :show, evaluation)

      conn = get(conn, Routes.evaluation_path(conn, :show, evaluation))
      assert html_response(conn, 200) =~ "some updated h3id"
    end

    test "renders errors when data is invalid", %{conn: conn, evaluation: evaluation} do
      conn = put(conn, Routes.evaluation_path(conn, :update, evaluation), evaluation: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Evaluation"
    end
  end

  describe "delete evaluation" do
    setup [:create_evaluation]

    test "deletes chosen evaluation", %{conn: conn, evaluation: evaluation} do
      conn = delete(conn, Routes.evaluation_path(conn, :delete, evaluation))
      assert redirected_to(conn) == Routes.evaluation_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.evaluation_path(conn, :show, evaluation))
      end
    end
  end

  defp create_evaluation(_) do
    evaluation = fixture(:evaluation)
    {:ok, evaluation: evaluation}
  end
end
