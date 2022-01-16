defmodule Scratch.Recipes.RecipeImage do
  use Ecto.Schema
  use Waffle.Ecto.Schema

  import Ecto.Changeset
  alias Scratch.Recipes.Recipe

  schema "recipe_images" do
    field :image_url, Scratch.FileImage.Type
    belongs_to :recipe, Recipe, foreign_key: :recipe_id
    timestamps()
  end

  @required ~w(image_url recipe_id)a
  @optional ~w()a
  @allowed @required ++ @optional

  @doc false
  def changeset(%__MODULE__{} = recipe_image, attrs) do
    recipe_image
    |> cast_attachments(attrs, [:image_url])
    |> validate_required(@required)
    |> foreign_key_constraint(:recipe_id)
  end

  def new_changeset(%__MODULE__{} = recipe_image, attrs \\ %{}) do
    IO.inspect("[[][][]][][")
    IO.inspect(attrs)

    recipe_image
    |> cast_attachments(attrs, [:image_url])
    |> validate_required([:image_url])
  end
end
