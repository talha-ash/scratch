defmodule Scratch.Recipes do
  use Ecto.Schema
  import Ecto.Changeset

  alias Scratch.Repo
  alias Scratch.Recipes.{Recipe, CookingStep, RecipeImage, Ingredient}

  def create_recipe(attrs \\ %{}) do
    {:ok, recipe} =
      %Recipe{}
      |> Recipe.changeset(attrs)
      |> Repo.insert()

    recipe
    |> Repo.preload([:cooking_steps, :ingredients, :recipe_images, :user])
    |> Recipe.associated_changeset(attrs)
    |> Repo.insert_or_update()
  end

  def update_recipe_images(id, recipe_images \\ %{}) do
    recipe_images = %{recipe_images: recipe_images}

    Repo.get(Recipe, id)
    |> Repo.preload(:recipe_images)
    |> RecipeImage.cast_assoc_recipe(recipe_images)
    |> Repo.update()
  end

  def update_recipe_ingredients(id, ingredients \\ %{}) do
    recipe = get_recipe_by_id(id)

    recipe
    |> Repo.preload(:ingredients)
    |> Ingredient.cast_assoc_recipe(ingredients, recipe.id)
    |> Repo.update()
  end

  def get_recipe(id) do
    get_recipe_by_id(id)
    |> Repo.preload([:cooking_steps, :ingredients, :recipe_images, :user])
  end

  defp get_recipe_by_id(id) do
    Repo.get(Recipe, id)
  end
end
