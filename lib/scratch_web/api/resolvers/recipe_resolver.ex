defmodule ScratchWeb.Resolvers.Recipe do
  alias Scratch.Accounts
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
end
