defmodule Scratch.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  alias Scratch.Accounts.User
  alias Scratch.Recipes.{CookingStep, RecipeImage, Ingredient}

  schema "recipes" do
    field :name, :string
    field :serve_time, :integer
    field :nutrition_facts, {:array, :string}

    belongs_to :user, User, foreign_key: :user_id
    has_many(:cooking_steps, CookingStep, on_replace: :delete)
    has_many(:recipe_images, RecipeImage, on_replace: :delete)
    has_many(:ingredients, Ingredient, on_replace: :delete)
    timestamps()
  end

  @required ~w(name serve_time nutrition_facts user_id)a
  @optional ~w()a
  @allowed @required ++ @optional

  @doc false
  def changeset(%__MODULE__{} = recipe, attrs) do
    recipe
    |> cast(attrs, @allowed)
    |> validate_required(@required)
    |> foreign_key_constraint(:user_id)
    |> cast_assoc(:ingredients, required: true, with: &Ingredient.new_changeset/2)
    |> cast_assoc(:cooking_steps, required: true, with: &CookingStep.new_changeset/2)
    |> cast_assoc(:recipe_images, required: true, with: &RecipeImage.new_changeset/2)
  end
end
