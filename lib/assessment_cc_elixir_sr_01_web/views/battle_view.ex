defmodule AssessmentCcElixirSr01Web.BattleView do
  use AssessmentCcElixirSr01Web, :view
  alias AssessmentCcElixirSr01Web.BattleView

  def render("index.json", %{battles: battles}) do
    %{data: render_many(battles, BattleView, "battle.json")}
  end

  def render("show.json", %{battle: battle}) do
    %{data: render_one(battle, BattleView, "battle.json")}
  end

  def render("battle.json", %{battle: battle}) do
    %{
      id: battle.id,
      winner: %{name: battle.winner_assoc.name},
      monster_a: %{name: battle.monster_a_assoc.name},
      monster_b: %{name: battle.monster_b_assoc.name}
    }
  end
end
