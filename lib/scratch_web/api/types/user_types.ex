defmodule ScratchWeb.Types.UserType do
  use Absinthe.Schema.Notation
  alias ScratchWeb.Resolvers.Users

  object :user_queries do
    @desc "Get All Users"
    field :users, list_of(:user) do
      resolve(&Users.list_users/2)
    end

    field :get_user_info, :user do
      resolve(&Users.get_user/2)
    end
  end

  @desc "A User"
  object :user do
    field :id, :id
    field :email, :string
    field :age, :string
    field :username, :string
  end
end
