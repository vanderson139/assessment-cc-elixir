defmodule AssessmentCcElixirSr01.MonstersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AssessmentCcElixirSr01.Monsters` context.
  """
  alias AssessmentCcElixirSr01.Repo

  @doc """
  Generate a monster.
  """
  def monster_fixture do
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

    {:ok, monster_3} =
      AssessmentCcElixirSr01.Monsters.create_monster(%{
        attack: 40,
        battles: [],
        defense: 20,
        hp: 50,
        image_url: "https://loremflickr.com/640/480",
        name: "My monster Test 3",
        speed: 10
      })

    {:ok, monster_4} =
      AssessmentCcElixirSr01.Monsters.create_monster(%{
        attack: 70,
        battles: [],
        defense: 20,
        hp: 50,
        image_url: "https://loremflickr.com/640/480",
        name: "My monster Test 4",
        speed: 40
      })

    {:ok, monster_5} =
      AssessmentCcElixirSr01.Monsters.create_monster(%{
        attack: 40,
        battles: [],
        defense: 20,
        hp: 100,
        image_url: "https://loremflickr.com/640/480",
        name: "My monster Test 5",
        speed: 40
      })

    {:ok, monster_6} =
      AssessmentCcElixirSr01.Monsters.create_monster(%{
        attack: 10,
        battles: [],
        defense: 10,
        hp: 100,
        image_url: "https://loremflickr.com/640/480",
        name: "My monster Test 6",
        speed: 80
      })

    {:ok, monster_7} =
      AssessmentCcElixirSr01.Monsters.create_monster(%{
        attack: 60,
        battles: [],
        defense: 10,
        hp: 150,
        image_url: "https://loremflickr.com/640/480",
        name: "My monster Test 7",
        speed: 40
      })

    %{
      monster_1:
        monster_1
        |> Repo.preload(battles: :winner_assoc)
        |> Repo.preload(battles: :monster_a_assoc)
        |> Repo.preload(battles: :monster_b_assoc),
      monster_2:
        monster_2
        |> Repo.preload(battles: :winner_assoc)
        |> Repo.preload(battles: :monster_a_assoc)
        |> Repo.preload(battles: :monster_b_assoc),
      monster_3:
        monster_3
        |> Repo.preload(battles: :winner_assoc)
        |> Repo.preload(battles: :monster_a_assoc)
        |> Repo.preload(battles: :monster_b_assoc),
      monster_4:
        monster_4
        |> Repo.preload(battles: :winner_assoc)
        |> Repo.preload(battles: :monster_a_assoc)
        |> Repo.preload(battles: :monster_b_assoc),
      monster_5:
        monster_5
        |> Repo.preload(battles: :winner_assoc)
        |> Repo.preload(battles: :monster_a_assoc)
        |> Repo.preload(battles: :monster_b_assoc),
      monster_6:
        monster_6
        |> Repo.preload(battles: :winner_assoc)
        |> Repo.preload(battles: :monster_a_assoc)
        |> Repo.preload(battles: :monster_b_assoc),
      monster_7:
        monster_7
        |> Repo.preload(battles: :winner_assoc)
        |> Repo.preload(battles: :monster_a_assoc)
        |> Repo.preload(battles: :monster_b_assoc)
    }
  end
end
