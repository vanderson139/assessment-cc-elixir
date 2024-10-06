defmodule AssessmentCcElixirSr01.Battles.Battle do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "battles" do
    belongs_to :winner_assoc, AssessmentCcElixirSr01.Monsters.Monster, foreign_key: :winner
    belongs_to :monster_a_assoc, AssessmentCcElixirSr01.Monsters.Monster, foreign_key: :monster_a
    belongs_to :monster_b_assoc, AssessmentCcElixirSr01.Monsters.Monster, foreign_key: :monster_b
    timestamps()
  end

  @doc false
  def changeset(battle, attrs) do
    battle
    |> cast(attrs, [:winner, :monster_a, :monster_b])
    |> validate_required([:winner, :monster_a, :monster_b])
  end
end
