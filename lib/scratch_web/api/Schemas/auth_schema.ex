defmodule ScratchWeb.Schema do
  use Absinthe.Schema

  import_types(ScratchWeb.Types.AuthType)
  alias ScratchWeb.Resolvers.Auth

  mutation do
    field :login, :login_success do
      arg(:username, :string)
      arg(:email, :string)
      arg(:password, non_null(:string))
      resolve(&Auth.login/3)
    end

    field :register, :login_success do
      arg(:username, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password_one, non_null(:string))
      arg(:password_two, non_null(:string))
      resolve(&Auth.register/3)
    end
  end
end
