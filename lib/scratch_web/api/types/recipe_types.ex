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

    # field :upload_file, :string do
    #   arg(:users, non_null(:upload))
    #   arg(:metadata, :upload)
    #   arg(:name, non_null(:string))
    #   arg(:nutrition_facts, non_null(list_of(:string)))
    #   arg(:recipe_images, non_null(list_of(:recipe_image_input)))
    #   arg(:ingredients, non_null(list_of(:ingredient_input)))
    #   arg(:cooking_steps, non_null(list_of(:cooking_step_input)))
    #   resolve(fn args, _ ->
    #     # this is a `%Plug.Upload{}` struct.
    #     args.users
    #     IO.inspect(args.nutrition_facts, label: "NUTRITION_FACTS")
    #     IO.inspect(args, label: "Arguments")
    #     {:ok, "success"}
    #   end)
    # end
  end

  input_object :ingredient_input do
    field :image_url, non_null(:string)
    field :description, non_null(:string)
  end

  input_object :cooking_step_input do
    field :step, non_null(:integer)
    field :description, non_null(:string)
    field :video_url, :string
    field :video_title, :string
  end

  input_object :recipe_image_input do
    field :image_url, non_null(:upload)
  end

  @desc "Create Recipe Successfull"
  object :create_recipe_success do
    field :id, :integer
    field :name, :string
  end
end
