defmodule ScratchWeb.Schema do
  use Absinthe.Schema

  import_types(ScratchWeb.Types.UserType)
  alias ScratchWeb.Resolvers.Users

  query do
    field :users, list_of(:user) do
      resolve(&Users.list_users/2)
    end
  end
end
