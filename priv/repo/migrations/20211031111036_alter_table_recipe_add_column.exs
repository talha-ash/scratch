defmodule Scratch.Repo.Migrations.AlterTableRecipeAddColumn do
  use Ecto.Migration

  def change do
    alter table(:recipes) do
      add(:cover_image_id, references("recipe_images"))
    end
  end
end
