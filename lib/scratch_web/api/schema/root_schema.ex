defmodule ScratchWeb.Schema do
  use Absinthe.Schema

  import_types(ScratchWeb.Types.AuthType)

  mutation do
    import_fields(:auth_mutations)
  end

  query do
    import_fields(:user_queries)
  end

  def middleware(middleware, _field, %Absinthe.Type.Object{identifier: identifier})
      when identifier in [:query, :subscription, :mutation] do
    [ScratchWeb.AuthorizationMiddleware | middleware]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end
end
