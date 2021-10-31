defmodule Scratch.Repo.Migrations.AddTableRecipe do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add(:name, :string)
      add(:serve_time, :integer)
      add(:ingredients, {:array, :string})
      add(:nutrition_facts, {:array, :string})
      # add(:cover_image_id, references("recipe_images"))
      timestamps()
    end
  end
end

# field :my_array, {:array, :float}
