defmodule Scratch.Recipes do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Scratch.Repo

  alias Scratch.Recipes.{
    Recipe,
    CookingStep,
    RecipeImage,
    Ingredient,
    Like,
    Category,
    SavedRecipe
  }

  def create_recipe(attrs \\ %{}) do
    recipe_changeset =
      %Recipe{}
      |> Recipe.changeset(attrs)

    case Repo.insert(recipe_changeset) do
      {:ok, recipe} ->
        recipe
        |> Repo.preload([:cooking_steps, :ingredients, :recipe_images, :user])
        |> Recipe.associated_changeset(attrs)
        |> Repo.insert_or_update()

      {:error, messeage} ->
        {:error, messeage}
    end
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

  def like_recipe(attrs) do
    %Like{}
    |> Like.changeset(attrs)
    |> Repo.insert()
  end

  def unlike_recipe(recipe_like) do
    Repo.delete(recipe_like)
  end

  def get_like_recipe(%{user_id: user_id, recipe_id: recipe_id}) do
    Repo.get_by(Like, user_id: user_id, recipe_id: recipe_id)
  end

  defp get_recipe_by_id(id) do
    Repo.get(Recipe, id)
  end

  def create_category(attrs) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  def save_recipe_by_category(attrs) do
    %SavedRecipe{}
    |> SavedRecipe.changeset(attrs)
    |> Repo.insert()
  end

  def get_categories(user_id) do
    Repo.all(
      from c in "categories",
        where: c.user_id == ^user_id,
        select: [:id, :title]
    )
  end
end
