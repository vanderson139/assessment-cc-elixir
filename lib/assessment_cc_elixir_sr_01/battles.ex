defmodule AssessmentCcElixirSr01.Battles do
  @moduledoc """
  The Battles context.
  """

  import Ecto.Query, warn: false
  alias AssessmentCcElixirSr01.Repo

  alias AssessmentCcElixirSr01.Battles.Battle
  alias AssessmentCcElixirSr01.Monsters.Monster

  @doc """
  Returns the list of battles.

  ## Examples

      iex> list_battles()
      [%Battle{}, ...]

  """
  def list_battles do
    Repo.all(Battle)
    |> Repo.preload(:winner_assoc)
    |> Repo.preload(:monster_a_assoc)
    |> Repo.preload(:monster_b_assoc)
  end

  @doc """
  Gets a single battle.

  Raises `Ecto.NoResultsError` if the Battle does not exist.

  ## Examples

      iex> get_battle!(123)
      %Battle{}

      iex> get_battle!(456)
      ** (Ecto.NoResultsError)

  """
  def get_battle!(id),
    do:
      Repo.get!(Battle, id)
      |> Repo.preload(:winner_assoc)
      |> Repo.preload(:monster_a_assoc)
      |> Repo.preload(:monster_b_assoc)

  @doc """
  Creates a battle.

  ## Examples

      iex> create_battle(%{field: value})
      {:ok, %Battle{}}

      iex> create_battle(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_battle(attrs \\ %{}) do
    %Battle{}
    |> Battle.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a battle.

  ## Examples

      iex> delete_battle(battle)
      {:ok, %Battle{}}

      iex> delete_battle(battle)
      {:error, %Ecto.Changeset{}}

  """
  def delete_battle(%Battle{} = battle) do
    Repo.delete(battle)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking battle changes.

  ## Examples

      iex> change_battle(battle)
      %Ecto.Changeset{data: %Battle{}}

  """
  def change_battle(%Battle{} = battle, attrs \\ %{}) do
    Battle.changeset(battle, attrs)
  end

  def start_battle(%Monster{} = monster_a, %Monster{} = monster_b) do
    with {first, second} <- determine_order(monster_a, monster_b),
         {:ok, winner} <- battle(first, second),
         {:ok, _} <-
           create_battle(%{monster_a: monster_a.id, monster_b: monster_b.id, winner: winner.id}) do
      {:ok, winner}
    else
      error ->
        {:error, :invalid_request}
    end
  end

  defp determine_order(monster1, monster2) do
    cond do
      monster1.speed > monster2.speed -> {monster1, monster2}
      monster1.speed < monster2.speed -> {monster2, monster1}
      monster1.attack > monster2.attack -> {monster1, monster2}
      true -> {monster2, monster1}
    end
  end

  defp calculate_damage(attacker, defender) do
    damage = attacker.attack - defender.defense
    if damage > 0, do: damage, else: 1
  end

  defp battle(attacker, defender) do
    damage = calculate_damage(attacker, defender)
    new_defender = %Monster{defender | hp: defender.hp - damage}

    if new_defender.hp <= 0 do
      {:ok, attacker}
    else
      battle(new_defender, attacker)
    end
  end
end
