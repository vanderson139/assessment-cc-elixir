defmodule AssessmentCcElixirSr01.Repo.Migrations.CreateBattles do
  use Ecto.Migration

  def change do
    create table(:battles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :winner, references(:monsters, on_delete: :nothing, type: :binary_id)
      add :monster_a, references(:monsters, on_delete: :nothing, type: :binary_id)
      add :monster_b, references(:monsters, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:battles, [:winner])
    create index(:battles, [:monster_a])
    create index(:battles, [:monster_b])
  end
end
