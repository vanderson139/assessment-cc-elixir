defmodule AssessmentCcElixirSr01.BattlesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AssessmentCcElixirSr01.Battles` context.
  """
  alias AssessmentCcElixirSr01.Repo

  @doc """
  Generate a battle.
  """
  def battle_fixture do
    {:ok, monster_1} =
      AssessmentCcElixirSr01.Monsters.create_monster(%{
        attack: 40,
        battles: [],
        defense: 20,
        hp: 50,
        image_url: "https://loremflickr.com/640/480",
        name: "My monster Test 1",
        speed: 80
      })

    {:ok, monster_2} =
      AssessmentCcElixirSr01.Monsters.create_monster(%{
        attack: 70,
        battles: [],
        defense: 20,
        hp: 100,
        image_url: "https://loremflickr.com/640/480",
        name: "My monster Test 2",
        speed: 40
      })

    {:ok, battle} =
      AssessmentCcElixirSr01.Battles.create_battle(%{
        monster_a: monster_1.id,
        monster_b: monster_2.id,
        winner: monster_1.id
      })

    %{
      battle:
        battle
        |> Repo.preload(:winner_assoc)
        |> Repo.preload(:monster_a_assoc)
        |> Repo.preload(:monster_b_assoc)
    }
  end
end
