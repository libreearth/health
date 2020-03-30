defmodule Health.Evaluations.Evaluation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "evaluations" do
    field :alcohol, :integer
    field :date_of_birth, :date
    field :do_you_work, :integer
    field :h3id, :string
    field :happiness, :integer
    field :previous_conditions, :integer
    field :previous_contact_with_sick, :integer
    field :smoker, :integer
    field :sports, :integer
    field :symptoms, :integer
    field :taking_precautions, :integer
    field :travel_to_risk, :integer
    field :household_number, :integer
    field :uuid, :string

    timestamps()
  end

  @doc false
  def changeset(evaluation, attrs) do
    attrs = attrs_symptoms(attrs)
    |> attrs_previous_conditions()

    evaluation
    |> cast(attrs, [:uuid, :date_of_birth, :h3id, :happiness, :smoker, :alcohol, :symptoms, :previous_conditions, :previous_contact_with_sick, :travel_to_risk, :do_you_work, :taking_precautions, :household_number, :sports])

    #|> validate_required([:uuid, :date_of_birth, :h3id, :happiness, :smoker, :alcohol, :symptoms, :previous_conditions, :previous_contact_with_sick, :travel_to_risk, :do_you_work, :taking_precautions, :sports])
  end


  defp attrs_symptoms(%{"symptoms" => ""} = attrs) do
    Map.replace!(attrs, "symptoms", 0)
  end

  defp attrs_symptoms(%{"symptoms" => _s} = attrs) do
    Map.replace!(attrs, "symptoms", 1)
  end

  defp attrs_symptoms(%{} = attrs) do
    attrs
  end

  defp attrs_previous_conditions(%{"previous_conditions" => ""} = attrs) do
    Map.replace!(attrs, "previous_conditions", 0)
  end

  defp attrs_previous_conditions(%{"previous_conditions" => _s} = attrs) do
    Map.replace!(attrs, "previous_conditions", 1)
  end

  defp attrs_previous_conditions(%{} = attrs) do
    attrs
  end
end
