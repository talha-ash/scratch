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
    with %Recipe{} = recipe <- get_recipe_by_id(id) do
      recipe
      |> Repo.preload(:recipe_images)
      |> RecipeImage.cast_assoc_with_recipe(recipe_images, recipe.id)
      |> Repo.update()
    else
      _ ->
        {:error, "Recipe not found"}
    end
  end

  def update_recipe(attrs \\ %{}) do
    with %Recipe{} = recipe <- get_recipe_by_id(attrs.id) do
      recipe
      |> Recipe.changeset(attrs)
      |> Repo.update()
    else
      _ ->
        {:error, "Recipe not found"}
    end
  end

  def update_recipe_cooking_steps(id, cooking_steps \\ %{}) do
    with %Recipe{} = recipe <- get_recipe_by_id(id) do
      recipe
      |> Repo.preload(:cooking_steps)
      |> CookingStep.cast_assoc_with_recipe(cooking_steps, recipe.id)
      |> Repo.update()
    else
      _ ->
        {:error, "Recipe not found"}
    end
  end

  def update_recipe_ingredients(id, ingredients \\ %{}) do
    with %Recipe{} = recipe <- get_recipe_by_id(id) do
      recipe
      |> Repo.preload(:ingredients)
      |> Ingredient.cast_assoc_with_recipe(ingredients, recipe.id)
      |> Repo.update()
    else
      _ ->
        {:error, "Recipe not found"}
    end
  end

  def get_recipe(id) do
    get_recipe_by_id(id)
    |> Repo.preload([:cooking_steps, :ingredients, :recipe_images])
  end

  defp get_recipe_by_id(id) do
    Repo.get(Recipe, id)
  end
end
