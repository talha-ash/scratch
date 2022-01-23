defmodule Scratch.Recipes.CookingStep do
  use Ecto.Schema
  import Ecto.Changeset

  alias Scratch.Recipes.Recipe

  schema "cooking_steps" do
    field :step, :integer
    field :description, :string
    field :video_url, :string
    field :video_title, :string
    belongs_to :recipe, Recipe, foreign_key: :recipe_id
    timestamps()
  end

  @required ~w(step description recipe_id)a
  @optional ~w(video_title video_url)a
  @allowed @required ++ @optional

  @doc false
  def changeset(%__MODULE__{} = cooking_step, attrs \\ %{}) do
    cooking_step
    |> cast(attrs, @allowed)
    |> validate_required(@required)
    |> foreign_key_constraint(:recipe_id)
  end

  def new_changeset(%__MODULE__{} = cooking_step, attrs \\ %{}) do
    cooking_step
    |> cast(attrs, [:step, :description, :video_url, :video_title])
    |> validate_required([:step, :description])
  end

  def cast_assoc_with_recipe(changeset) do
    changeset
    |> cast_assoc(:cooking_steps, required: true, with: &new_changeset/2)
  end
end
