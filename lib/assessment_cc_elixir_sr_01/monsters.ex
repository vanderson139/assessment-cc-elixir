defmodule AssessmentCcElixirSr01.Monsters do
  @moduledoc """
  The Monsters context.
  """

  import Ecto.Query, warn: false
  alias AssessmentCcElixirSr01.Repo

  alias AssessmentCcElixirSr01.Monsters.Monster

  @doc """
  Returns the list of monsters.

  ## Examples

      iex> list_monsters()
      [%Monster{}, ...]

  """
  def list_monsters do
    Repo.all(Monster)
    |> Repo.preload(battles: :winner_assoc)
    |> Repo.preload(battles: :monster_a_assoc)
    |> Repo.preload(battles: :monster_b_assoc)
  end

  @doc """
  Gets a single monster.

  Raises `Ecto.NoResultsError` if the Monster does not exist.

  ## Examples

      iex> get_monster!(123)
      %Monster{}

      iex> get_monster!(456)
      ** (Ecto.NoResultsError)

  """
  def get_monster!(id),
    do:
      Repo.get!(Monster, id)
      |> Repo.preload(battles: :winner_assoc)
      |> Repo.preload(battles: :monster_a_assoc)
      |> Repo.preload(battles: :monster_b_assoc)

  @doc """
  Creates a monster.

  ## Examples

      iex> create_monster(%{field: value})
      {:ok, %Monster{}}

      iex> create_monster(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_monster(attrs \\ %{}) do
    %Monster{}
    |> Monster.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a monster.

  ## Examples

      iex> update_monster(monster, %{field: new_value})
      {:ok, %Monster{}}

      iex> update_monster(monster, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_monster(%Monster{} = monster, attrs) do
    monster
    |> Monster.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a monster.

  ## Examples

      iex> delete_monster(monster)
      {:ok, %Monster{}}

      iex> delete_monster(monster)
      {:error, %Ecto.Changeset{}}

  """
  def delete_monster(%Monster{} = monster) do
    Repo.delete(monster)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking monster changes.

  ## Examples

      iex> change_monster(monster)
      %Ecto.Changeset{data: %Monster{}}

  """
  def change_monster(%Monster{} = monster, attrs \\ %{}) do
    Monster.changeset(monster, attrs)
  end

  def insert_monsters(items) do
    Monster
    |> Repo.insert_all(items,
      on_conflict: :nothing,
      returning: true
    )
  end

  def convert_params(data) do
    data
    |> Enum.map(fn monsters ->
      monsters
      |> Enum.map(fn monster -> monster end)
      |> Enum.map(fn {key, value} -> {key, value} end)
      |> Enum.into(%{})
      |> convert()
    end)
  end

  def convert(data) do
    for {key, val} <- data, into: %{}, do: {String.to_atom(key), val}
  end

  def parse_fields(monster) do
    timestamp =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.truncate(:second)

    monster
    |> Map.put("inserted_at", timestamp)
    |> Map.put("updated_at", timestamp)
  end
end
