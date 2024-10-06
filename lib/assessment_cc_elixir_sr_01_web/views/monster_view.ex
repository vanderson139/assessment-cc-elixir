defmodule AssessmentCcElixirSr01Web.MonsterView do
  use AssessmentCcElixirSr01Web, :view
  alias AssessmentCcElixirSr01Web.BattleView
  alias AssessmentCcElixirSr01Web.MonsterView

  def render("index.json", %{monsters: monsters}) do
    %{data: render_many(monsters, MonsterView, "monster.json")}
  end

  def render("show.json", %{monster: monster}) do
    %{data: render_one(monster, MonsterView, "monster.json")}
  end

  def render("monster.json", %{monster: monster}) do
    %{
      id: monster.id,
      name: monster.name,
      image_url: monster.image_url,
      attack: monster.attack,
      defense: monster.defense,
      hp: monster.hp,
      speed: monster.speed,
      battles: render_many(monster.battles, BattleView, "battle.json")
    }
  end
end
