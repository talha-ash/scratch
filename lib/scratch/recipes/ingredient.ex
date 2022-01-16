defmodule Scratch.Recipes.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  alias Scratch.Recipes.Recipe

  schema "ingredients" do
    field :description, :string
    field :image_url, :string
    belongs_to :recipe, Recipe, foreign_key: :recipe_id
    timestamps()
  end

  @required ~w(description recipe_id)a
  @optional ~w(image_url)a
  @allowed @required ++ @optional

  @doc false
  def changeset(%__MODULE__{} = ingredient, attrs \\ %{}) do
    ingredient
    |> cast(attrs, @allowed)
    |> validate_required(@required)
    |> foreign_key_constraint(:recipe_id)
  end

  def new_changeset(%__MODULE__{} = ingredient, attrs \\ %{}) do
    ingredient
    |> cast(attrs, [:description, :image_url])
    |> validate_required([:description])
  end
end
