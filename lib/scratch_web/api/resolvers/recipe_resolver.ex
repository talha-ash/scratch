defmodule ScratchWeb.Resolvers.Recipe do
  alias Scratch.Recipes

  def create_recipe(_parent, args, %{context: %{current_user: current_user}}) do
    args = Map.put(args, :user_id, current_user.id)

    with {:ok, %Recipes.Recipe{} = recipe} <- Recipes.create_recipe(args) do
      {:ok, recipe}
    else
      {:error, message} ->
        {:error, message}
    end
  end

  def update_recipe_ingredients(_parent, args, %{context: %{current_user: _current_user}}) do
    with {:ok, %Recipes.Recipe{} = recipe} <-
           Recipes.update_recipe_ingredients(args.id, Map.delete(args, :id)) do
      {:ok, %{ingredients: recipe.ingredients}}
    else
      {:error, message} ->
        {:error, message}
    end
  end

  def update_recipe_images(_parent, args, %{context: %{current_user: _current_user}}) do
    with {:ok, %Recipes.Recipe{} = recipe} <-
           Recipes.update_recipe_images(args.id, Map.delete(args, :id)) do
      {:ok, %{recipe_images: recipe.recipe_images}}
    else
      {:error, message} ->
        {:error, message}
    end
  end

  def get_recipe(_parent, args, %{context: %{current_user: current_user}}) do
    args = Map.put(args, :user_id, current_user.id)

    recipe = Recipes.get_recipe(args.id)
    {:ok, recipe}
  end

  def resolve_images(parent, _args, %{context: %{current_user: _current_user}}) do
    if(parent.id && Map.has_key?(parent, :image) && Map.has_key?(parent.image, :file_name)) do
      file_name = parent.image.file_name
      {:ok, Scratch.FileImage.url({file_name, %{scope_id: parent.id}})}
    else
      {:ok, ""}
    end
  end
end
