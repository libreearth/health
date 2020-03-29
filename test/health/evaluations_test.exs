defmodule Health.EvaluationsTest do
  use Health.DataCase

  alias Health.Evaluations

  describe "evaluations" do
    alias Health.Evaluations.Evaluation

    @valid_attrs %{alcohol: 42, date_of_birth: ~D[2010-04-17], do_you_work: 42, h3id: "some h3id", happiness: 42, previous_conditions: 42, previous_contact_with_sick: 42, smoker: 42, sports: 42, symptoms: 42, taking_precautions: 42, travel_to_risk: 42, uuid: "some uuid"}
    @update_attrs %{alcohol: 43, date_of_birth: ~D[2011-05-18], do_you_work: 43, h3id: "some updated h3id", happiness: 43, previous_conditions: 43, previous_contact_with_sick: 43, smoker: 43, sports: 43, symptoms: 43, taking_precautions: 43, travel_to_risk: 43, uuid: "some updated uuid"}
    @invalid_attrs %{alcohol: nil, date_of_birth: nil, do_you_work: nil, h3id: nil, happiness: nil, previous_conditions: nil, previous_contact_with_sick: nil, smoker: nil, sports: nil, symptoms: nil, taking_precautions: nil, travel_to_risk: nil, uuid: nil}

    def evaluation_fixture(attrs \\ %{}) do
      {:ok, evaluation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Evaluations.create_evaluation()

      evaluation
    end

    test "list_evaluations/0 returns all evaluations" do
      evaluation = evaluation_fixture()
      assert Evaluations.list_evaluations() == [evaluation]
    end

    test "get_evaluation!/1 returns the evaluation with given id" do
      evaluation = evaluation_fixture()
      assert Evaluations.get_evaluation!(evaluation.id) == evaluation
    end

    test "create_evaluation/1 with valid data creates a evaluation" do
      assert {:ok, %Evaluation{} = evaluation} = Evaluations.create_evaluation(@valid_attrs)
      assert evaluation.alcohol == 42
      assert evaluation.date_of_birth == ~D[2010-04-17]
      assert evaluation.do_you_work == 42
      assert evaluation.h3id == "some h3id"
      assert evaluation.happiness == 42
      assert evaluation.previous_conditions == 42
      assert evaluation.previous_contact_with_sick == 42
      assert evaluation.smoker == 42
      assert evaluation.sports == 42
      assert evaluation.symptoms == 42
      assert evaluation.taking_precautions == 42
      assert evaluation.travel_to_risk == 42
      assert evaluation.uuid == "some uuid"
    end

    test "create_evaluation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Evaluations.create_evaluation(@invalid_attrs)
    end

    test "update_evaluation/2 with valid data updates the evaluation" do
      evaluation = evaluation_fixture()
      assert {:ok, %Evaluation{} = evaluation} = Evaluations.update_evaluation(evaluation, @update_attrs)
      assert evaluation.alcohol == 43
      assert evaluation.date_of_birth == ~D[2011-05-18]
      assert evaluation.do_you_work == 43
      assert evaluation.h3id == "some updated h3id"
      assert evaluation.happiness == 43
      assert evaluation.previous_conditions == 43
      assert evaluation.previous_contact_with_sick == 43
      assert evaluation.smoker == 43
      assert evaluation.sports == 43
      assert evaluation.symptoms == 43
      assert evaluation.taking_precautions == 43
      assert evaluation.travel_to_risk == 43
      assert evaluation.uuid == "some updated uuid"
    end

    test "update_evaluation/2 with invalid data returns error changeset" do
      evaluation = evaluation_fixture()
      assert {:error, %Ecto.Changeset{}} = Evaluations.update_evaluation(evaluation, @invalid_attrs)
      assert evaluation == Evaluations.get_evaluation!(evaluation.id)
    end

    test "delete_evaluation/1 deletes the evaluation" do
      evaluation = evaluation_fixture()
      assert {:ok, %Evaluation{}} = Evaluations.delete_evaluation(evaluation)
      assert_raise Ecto.NoResultsError, fn -> Evaluations.get_evaluation!(evaluation.id) end
    end

    test "change_evaluation/1 returns a evaluation changeset" do
      evaluation = evaluation_fixture()
      assert %Ecto.Changeset{} = Evaluations.change_evaluation(evaluation)
    end
  end
end
