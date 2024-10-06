defmodule AssessmentCcElixirSr01Web.MonsterController do
  use AssessmentCcElixirSr01Web, :controller

  alias AssessmentCcElixirSr01.Monsters
  alias AssessmentCcElixirSr01.Monsters.Monster
  alias AssessmentCcElixirSr01.Repo

  action_fallback AssessmentCcElixirSr01Web.FallbackController

  def index(conn, _params) do
    monsters = Monsters.list_monsters()
    render(conn, "index.json", monsters: monsters)
  end

  def create(conn, monster_params) do
    with {:ok, %Monster{} = monster} <- Monsters.create_monster(monster_params) do
      monster =
        monster
        |> Repo.preload(battles: :winner_assoc)
        |> Repo.preload(battles: :monster_a_assoc)
        |> Repo.preload(battles: :monster_b_assoc)

      conn
      |> put_status(:created)
      |> render("show.json", monster: monster)
    end
  end

  def show(conn, %{"id" => id}) do
    monster = Monsters.get_monster!(id)
    render(conn, "show.json", monster: monster)
  end

  def update(conn, %{"id" => id} = monster_params) do
    monster = Monsters.get_monster!(id)

    with {:ok, %Monster{} = monster} <- Monsters.update_monster(monster, monster_params) do
      render(conn, "show.json", monster: monster)
    end
  end

  def delete(conn, %{"id" => id}) do
    monster = Monsters.get_monster!(id)

    with {:ok, %Monster{}} <- Monsters.delete_monster(monster) do
      send_resp(conn, :no_content, "")
    end
  end

  def import(conn, %{"csv" => csv}) do
    case csv_decoder(csv) do
      {:error, :empty_error} ->
        send_error_response(conn, 400, "Empty monster.")

      {:error, :mappping_error} ->
        send_error_response(conn, 400, "Wrong data mapping.")

      data ->
        import_monsters(data)

        conn
        |> put_resp_content_type("application/json")
        |> send_resp(:ok, "{\"data\":{\"message\": \"Records were imported successfully.\" }}")
    end
  end

  defp send_error_response(conn, status, message) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, "{\"errors\":{\"detail\":\"#{message}\"}}")
  end

  defp csv_decoder(file) do
    try do
      "#{file.path}"
      |> Path.expand(__DIR__)
      |> File.stream!()
      |> CSV.decode(headers: true)
      |> Stream.map(fn row ->
        case row do
          {:ok, monster} ->
            attack = Map.get(monster, "attack")
            defense = Map.get(monster, "defense")
            hp = Map.get(monster, "hp")
            speed = Map.get(monster, "speed")

            with {attack_int_val, ""} <- Integer.parse(attack),
                 {defense_int_val, ""} <- Integer.parse(defense),
                 {hp_int_val, ""} <- Integer.parse(hp),
                 {speed_int_val, ""} <- Integer.parse(speed) do
              {:ok,
               Map.merge(monster, %{
                 "attack" => attack_int_val,
                 "defense" => defense_int_val,
                 "hp" => hp_int_val,
                 "speed" => speed_int_val
               })}
            else
              _ ->
                raise "empty_error"
            end
        end
      end)
      |> Enum.map(fn data -> data end)
    rescue
      RuntimeError ->
        {:error, :empty_error}

      _ ->
        {:error, :mappping_error}
    end
  end

  defp import_monsters(data) do
    monsters = Enum.map(data, fn {:ok, monster} -> parse(monster) end)
    params = Monsters.convert_params(monsters)
    {_, _} = Monsters.insert_monsters(params)
  end

  defp parse(monster) do
    Monsters.parse_fields(monster)
  end
end
