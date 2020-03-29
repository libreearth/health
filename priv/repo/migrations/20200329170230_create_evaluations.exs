defmodule Health.Repo.Migrations.CreateEvaluations do
  use Ecto.Migration

  def change do
    create table(:evaluations) do
      add :uuid, :string
      add :date_of_birth, :date
      add :h3id, :string
      add :happiness, :integer
      add :smoker, :integer
      add :alcohol, :integer
      add :symptoms, :integer
      add :previous_conditions, :integer
      add :previous_contact_with_sick, :integer
      add :travel_to_risk, :integer
      add :do_you_work, :integer
      add :taking_precautions, :integer
      add :sports, :integer

      timestamps()
    end

  end
end
