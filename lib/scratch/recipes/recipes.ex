defmodule Scratch.Recipes do
  use Ecto.Schema
  import Ecto.Changeset

  alias Scratch.Repo
  alias Scratch.Recipes.{Recipe}

  def create_recipe(attrs \\ %{}) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end
end
