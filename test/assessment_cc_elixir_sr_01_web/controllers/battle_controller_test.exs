defmodule AssessmentCcElixirSr01Web.BattleControllerTest do
  use AssessmentCcElixirSr01Web.ConnCase

  import AssessmentCcElixirSr01.MonstersFixtures
  import AssessmentCcElixirSr01.BattlesFixtures

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all battles", %{conn: conn} do
      conn = get(conn, Routes.battle_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create battle" do
    test "render monster_a as a winner with success response", %{conn: conn} do
      %{monster_1: monster_b, monster_2: monster_a} = monster_fixture()

      conn =
        post(conn, Routes.battle_path(conn, :create), %{
          "monster1" => monster_a.id,
          "monster2" => monster_b.id
        })

      assert json_response(conn, 200)["winner"] == monster_a.name
    end

    test "render monster_b as a winner with success response", %{conn: conn} do
      %{monster_1: monster_a, monster_2: monster_b} = monster_fixture()

      conn =
        post(conn, Routes.battle_path(conn, :create), %{
          "monster1" => monster_a.id,
          "monster2" => monster_b.id
        })

      assert json_response(conn, 200)["winner"] == monster_b.name
    end

    test "render monster_a as a winner when their speeds same and monster_a has higher attack", %{
      conn: conn
    } do
      %{monster_4: monster_a, monster_5: monster_b} = monster_fixture()

      assert monster_a.speed == monster_b.speed
      assert monster_a.attack > monster_b.attack

      conn =
        post(conn, Routes.battle_path(conn, :create), %{
          "monster1" => monster_a.id,
          "monster2" => monster_b.id
        })

      assert json_response(conn, 200)["winner"] == monster_a.name
    end

    test "render monster_b as a winner when their speeds same and monster_b has higher attack", %{
      conn: conn
    } do
      %{monster_4: monster_b, monster_5: monster_a} = monster_fixture()

      assert monster_a.speed == monster_b.speed
      assert monster_a.attack < monster_b.attack

      conn =
        post(conn, Routes.battle_path(conn, :create), %{
          "monster1" => monster_a.id,
          "monster2" => monster_b.id
        })

      assert json_response(conn, 200)["winner"] == monster_b.name
    end

    test "render monster_a as a winner when their defenses same and monster_a has higher attack",
         %{conn: conn} do
      %{monster_4: monster_a, monster_5: monster_b} = monster_fixture()

      assert monster_a.defense == monster_b.defense
      assert monster_a.attack > monster_b.attack

      conn =
        post(conn, Routes.battle_path(conn, :create), %{
          "monster1" => monster_a.id,
          "monster2" => monster_b.id
        })

      assert json_response(conn, 200)["winner"] == monster_a.name
    end

    test "renders bad request error when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.battle_path(conn, :create), %{monster1: "asdsad'", monster2: "asdasd"})

      assert %{"errors" => %{"detail" => "Bad request."}} = json_response(conn, 400)
    end
  end

  describe "delete battle" do
    test "deletes chosen battle", %{conn: conn} do
      %{battle: %{id: id}} = battle_fixture()
      conn = post(conn, Routes.battle_path(conn, :delete, id), %{"_method" => "DELETE"})

      assert %{"data" => %{"id" => ^id}} = json_response(conn, 200)
    end
  end
end
