defmodule Scratch.Repo.Migrations.AddTableCookbookCategories do
  use Ecto.Migration

  def change do
    create table(:cookbook_categories) do
      add(:title, :string)
      add(:user_id, references("users"))
      timestamps()
    end

    create(unique_index(:cookbook_categories, [:title, :user_id]))
  end
end
