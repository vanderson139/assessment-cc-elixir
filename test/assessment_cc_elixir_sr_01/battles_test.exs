defmodule AssessmentCcElixirSr01.BattlesTest do
  use AssessmentCcElixirSr01.DataCase

  alias AssessmentCcElixirSr01.Battles

  describe "battles" do
    alias AssessmentCcElixirSr01.Battles.Battle

    import AssessmentCcElixirSr01.BattlesFixtures
    import AssessmentCcElixirSr01.MonstersFixtures

    @invalid_attrs %{monster_a: nil, monster_b: nil, winner: nil}

    test "list_battles/0 returns all battles" do
      %{battle: battle} = battle_fixture()
      assert Battles.list_battles() == [battle]
    end

    test "get_battle!/1 returns the battle with given id" do
      %{battle: battle} = battle_fixture()
      assert Battles.get_battle!(battle.id) == battle
    end

    test "create_battle/1 with valid data creates a battle" do
      %{monster_1: monster_1, monster_2: monster_2} = monster_fixture()

      valid_attrs = %{
        monster_a: monster_1.id,
        monster_b: monster_2.id,
        winner: monster_1.id
      }

      assert {:ok, %Battle{} = battle} = Battles.create_battle(valid_attrs)
      assert battle.monster_a == monster_1.id
      assert battle.monster_b == monster_2.id
      assert battle.winner == monster_1.id
    end

    test "create_battle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Battles.create_battle(@invalid_attrs)
    end

    test "delete_battle/1 deletes the battle" do
      %{battle: battle} = battle_fixture()
      assert {:ok, %Battle{}} = Battles.delete_battle(battle)
      assert_raise Ecto.NoResultsError, fn -> Battles.get_battle!(battle.id) end
    end

    test "change_battle/1 returns a battle changeset" do
      %{battle: battle} = battle_fixture()
      assert %Ecto.Changeset{} = Battles.change_battle(battle)
    end
  end
end
