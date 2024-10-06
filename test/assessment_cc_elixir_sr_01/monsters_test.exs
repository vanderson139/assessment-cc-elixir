defmodule AssessmentCcElixirSr01.MonstersTest do
  use AssessmentCcElixirSr01.DataCase

  alias AssessmentCcElixirSr01.Monsters

  describe "monsters" do
    alias AssessmentCcElixirSr01.Monsters.Monster

    import AssessmentCcElixirSr01.MonstersFixtures

    @invalid_attrs %{attack: nil, defense: nil, hp: nil, image_url: nil, name: nil, speed: nil}

    test "list_monsters/0 returns all monsters" do
      %{
        monster_1: monster_1,
        monster_2: monster_2,
        monster_3: monster_3,
        monster_4: monster_4,
        monster_5: monster_5,
        monster_6: monster_6,
        monster_7: monster_7
      } = monster_fixture()

      assert Monsters.list_monsters() == [
               monster_1,
               monster_2,
               monster_3,
               monster_4,
               monster_5,
               monster_6,
               monster_7
             ]
    end

    test "get_monster!/1 returns the monster with given id" do
      %{monster_1: monster_1} = monster_fixture()
      assert Monsters.get_monster!(monster_1.id) == monster_1
    end

    test "create_monster/1 with valid data creates a monster" do
      valid_attrs = %{
        attack: 42,
        defense: 42,
        hp: 42,
        image_url: "some image_url",
        name: "some name",
        speed: 42
      }

      assert {:ok, %Monster{} = monster} = Monsters.create_monster(valid_attrs)
      assert monster.attack == 42
      assert monster.defense == 42
      assert monster.hp == 42
      assert monster.image_url == "some image_url"
      assert monster.name == "some name"
      assert monster.speed == 42
    end

    test "create_monster/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Monsters.create_monster(@invalid_attrs)
    end

    test "update_monster/2 with valid data updates the monster" do
      %{monster_1: monster_1} = monster_fixture()

      update_attrs = %{
        attack: 43,
        battles: [],
        defense: 43,
        hp: 43,
        image_url: "some updated image_url",
        name: "some updated name",
        speed: 43
      }

      assert {:ok, %Monster{} = monster} = Monsters.update_monster(monster_1, update_attrs)
      assert monster.attack == 43
      assert monster.defense == 43
      assert monster.hp == 43
      assert monster.image_url == "some updated image_url"
      assert monster.name == "some updated name"
      assert monster.speed == 43
    end

    test "update_monster/2 with invalid data returns error changeset" do
      %{monster_1: monster_1} = monster_fixture()
      assert {:error, %Ecto.Changeset{}} = Monsters.update_monster(monster_1, @invalid_attrs)
      assert monster_1 == Monsters.get_monster!(monster_1.id)
    end

    test "delete_monster/1 deletes the monster" do
      %{monster_1: monster_1} = monster_fixture()
      assert {:ok, %Monster{}} = Monsters.delete_monster(monster_1)
      assert_raise Ecto.NoResultsError, fn -> Monsters.get_monster!(monster_1.id) end
    end

    test "change_monster/1 returns a monster changeset" do
      %{monster_1: monster_1} = monster_fixture()
      assert %Ecto.Changeset{} = Monsters.change_monster(monster_1)
    end
  end
end
