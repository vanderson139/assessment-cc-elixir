defmodule AssessmentCcElixirSr01.Monsters.Monster do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "monsters" do
    field :attack, :integer
    field :defense, :integer
    field :hp, :integer
    field :image_url, :string
    field :name, :string
    field :speed, :integer

    has_many :battles, AssessmentCcElixirSr01.Battles.Battle,
      foreign_key: :monster_a,
      references: :id

    timestamps()
  end

  @doc false
  def changeset(monster, attrs) do
    monster
    |> cast(attrs, [:name, :image_url, :attack, :defense, :hp, :speed])
    |> validate_required([:name, :image_url, :attack, :defense, :hp, :speed])
  end
end
