defmodule ScratchWeb.Types.RecipeType do
  use Absinthe.Schema.Notation
  alias ScratchWeb.Resolvers.Recipe
  import_types(Absinthe.Plug.Types)

  object :recipe_mutations do
    @desc "Create Recipe"
    field :create_recipe, :create_recipe_success do
      arg(:name, non_null(:string))
      arg(:serve_time, non_null(:integer))
      arg(:nutrition_facts, non_null(list_of(:string)))
      arg(:cooking_steps, non_null(list_of(:cooking_step_input)))
      arg(:recipe_images, non_null(list_of(:recipe_image_input)))
      arg(:ingredients, non_null(list_of(:ingredient_input)))
      resolve(&Recipe.create_recipe/3)
    end

    @desc "Update Recipe Images"
    field :update_recipe_images, :create_recipe_success do
      arg(:id, non_null(:id))
      arg(:recipe_images, list_of(:recipe_image_input))
      resolve(&Recipe.update_recipe_images/3)
    end

    @desc "Update Recipe Ingredients"
    field :update_recipe_ingredients, :update_recipe_ingredients_success do
      arg(:id, non_null(:id))
      arg(:ingredients, list_of(:ingredient_input))
      resolve(&Recipe.update_recipe_ingredients/3)
    end
  end

  object :recipe_queries do
    @desc "Get Recipe"
    field :get_recipe, :recipe do
      arg(:id, non_null(:id))
      resolve(&Recipe.get_recipe/3)
    end
  end

  input_object :ingredient_input do
    field :id, :id
    field :image, :upload
    field :description, non_null(:string)
  end

  input_object :cooking_step_input do
    field :step, non_null(:integer)
    field :description, non_null(:string)
    field :video_url, :string
    field :video_title, :string
  end

  input_object :recipe_image_input do
    field :image, :upload
  end

  @desc "Create Recipe Successfull"
  object :create_recipe_success do
    field :id, :integer
    field :name, :string
  end

  @desc "Update Recipe Ingredient Successfull"
  object :update_recipe_ingredients_success do
    field :ingredients, list_of(:ingredient)
  end

  object :ingredient do
    field :description, :string

    field :image_url, :string do
      resolve(&Recipe.resolve_images/3)
    end
  end

  object :recipe_image do
    field :image_url, :string do
      resolve(&Recipe.resolve_images/3)
    end
  end

  object :cooking_step do
    field :step, :integer
    field :description, :string
    field :video_url, :string
    field :video_title, :string
  end

  object :recipe do
    field :id, :id
    field :name, :string
    field :serve_time, :integer
    field :nutrition_facts_url, :string
    field :ingredients, list_of(:ingredient)
    field :cooking_steps, list_of(:cooking_step)
    field :recipe_images, list_of(:recipe_image)
  end
end