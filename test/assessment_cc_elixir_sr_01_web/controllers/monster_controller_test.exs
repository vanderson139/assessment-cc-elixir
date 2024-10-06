defmodule AssessmentCcElixirSr01Web.MonsterControllerTest do
  use AssessmentCcElixirSr01Web.ConnCase

  import AssessmentCcElixirSr01.MonstersFixtures

  alias AssessmentCcElixirSr01.Monsters.Monster

  @create_attrs %{
    attack: 42,
    defense: 42,
    hp: 42,
    image_url: "some image_url",
    name: "some name",
    speed: 42
  }
  @update_attrs %{
    attack: 43,
    defense: 43,
    hp: 43,
    image_url: "some updated image_url",
    name: "some updated name",
    speed: 43
  }
  @invalid_attrs %{attack: nil, defense: nil, hp: nil, image_url: nil, name: nil, speed: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all monsters", %{conn: conn} do
      conn = get(conn, Routes.monster_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create monster" do
    test "renders monster when data is valid", %{conn: conn} do
      conn = post(conn, Routes.monster_path(conn, :create), @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.monster_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "attack" => 42,
               "defense" => 42,
               "hp" => 42,
               "image_url" => "some image_url",
               "name" => "some name",
               "speed" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.monster_path(conn, :create), monster: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update monster" do
    test "renders monster when data is valid", %{conn: conn} do
      %{monster_1: monster_1} = monster_fixture()
      %Monster{id: id} = monster_1

      conn = put(conn, Routes.monster_path(conn, :update, id), @update_attrs)
      assert %{"id" => id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.monster_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "attack" => 43,
               "defense" => 43,
               "hp" => 43,
               "image_url" => "some updated image_url",
               "name" => "some updated name",
               "speed" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      %{monster_1: monster_1} = monster_fixture()
      %Monster{id: id} = monster_1
      conn = put(conn, Routes.monster_path(conn, :update, id), @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete monster" do
    test "deletes chosen monster", %{conn: conn} do
      %{monster_1: monster_1} = monster_fixture()

      conn = delete(conn, Routes.monster_path(conn, :delete, monster_1))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.monster_path(conn, :show, monster_1))
      end
    end
  end

  describe "import CSV" do
    test "render success response when monster correct column", %{conn: conn} do
      file_path =
        "../../support/files/monsters-correct.csv"
        |> Path.expand(__DIR__)

      upload = %Plug.Upload{path: file_path, filename: "valid_monsters.csv"}
      conn = post(conn, Routes.monster_path(conn, :import), csv: upload)

      assert %{"data" => %{"message" => "Records were imported successfully."}} =
               json_response(conn, 200)
    end

    test "render bad request error when monster csv has a wrong column", %{conn: conn} do
      file_path =
        "../../support/files/monsters-wrong-column.csv"
        |> Path.expand(__DIR__)

      upload = %Plug.Upload{path: file_path, filename: "invalid_monsters_wrong_column.csv"}
      conn = post(conn, Routes.monster_path(conn, :import), csv: upload)
      assert %{"errors" => %{"detail" => "Wrong data mapping."}} = json_response(conn, 400)
    end

    test "render bad request error when monster csv has an empty monster", %{conn: conn} do
      file_path =
        "../../support/files/monsters-empty-monster.csv"
        |> Path.expand(__DIR__)

      upload = %Plug.Upload{path: file_path, filename: "invalid_monsters_empty.csv"}
      conn = post(conn, Routes.monster_path(conn, :import), csv: upload)
      assert %{"errors" => %{"detail" => "Empty monster."}} = json_response(conn, 400)
    end
  end
end
