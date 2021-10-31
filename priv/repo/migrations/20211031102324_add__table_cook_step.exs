defmodule Scratch.Repo.Migrations.AddTableCookStep do
  use Ecto.Migration

  def change do
    create table(:cook_steps) do
      add(:step, :string)
      add(:description, :string)
      add(:video_url, :string)
      add(:video_title, :string)
      add(:recipe_id, references("recipes"))
      timestamps()
    end

    create(index(:cook_steps, [:recipe_id]))
  end
end
