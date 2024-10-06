defmodule AssessmentCcElixirSr01Web.BattleController do
  use AssessmentCcElixirSr01Web, :controller

  alias AssessmentCcElixirSr01.Battles
  alias AssessmentCcElixirSr01.Monsters

  action_fallback AssessmentCcElixirSr01Web.FallbackController

  def index(conn, _params) do
    battles = Battles.list_battles()
    render(conn, "index.json", battles: battles)
  end

  def show(conn, %{"id" => id}) do
    battle = Battles.get_battle!(id)
    render(conn, "show.json", battle: battle)
  end

  def create(conn, %{"monster1" => monster1_id, "monster2" => monster2_id}) do
    monster1 = Monsters.get_monster!(monster1_id)
    monster2 = Monsters.get_monster!(monster2_id)

    case Battles.start_battle(monster1, monster2) do
      {:ok, winner} ->
        json(conn, %{winner: winner.name, remaining_hp: winner.hp})

      _ ->
        raise "error"
    end
  rescue
    _ ->
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(400, "{\"errors\":{\"detail\":\"Bad request.\"}}")
  end

  def delete(conn, %{"id" => id}) do
    {:ok, battle} =
      Battles.get_battle!(id)
      |> Battles.delete_battle()

    render(conn, "show.json", battle: battle)
  end
end
