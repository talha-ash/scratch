defmodule ScratchWeb.Schema do
  use Absinthe.Schema

  import_types(ScratchWeb.Types.AuthType)
  import_types(ScratchWeb.Types.RecipeType)
  alias Crudry.Middlewares.TranslateErrors

  mutation do
    import_fields(:auth_mutations)
    import_fields(:recipe_mutations)
  end

  query do
    import_fields(:user_queries)
    import_fields(:recipe_queries)
  end

  def middleware(middleware, _field, %Absinthe.Type.Object{identifier: identifier})
      when identifier in [:query, :subscription, :mutation] do
    [ScratchWeb.AuthorizationMiddleware | middleware] ++ [TranslateErrors]
  end

  def middleware(middleware, _field, _object) do
    middleware ++ [TranslateErrors]
  end
end
