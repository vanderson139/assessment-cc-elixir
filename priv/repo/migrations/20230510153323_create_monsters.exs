defmodule AssessmentCcElixirSr01.Repo.Migrations.CreateMonsters do
  use Ecto.Migration

  def change do
    create table(:monsters, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :image_url, :string
      add :attack, :integer
      add :defense, :integer
      add :hp, :integer
      add :speed, :integer

      timestamps()
    end
  end
end
