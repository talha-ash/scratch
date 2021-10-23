defmodule ScratchWeb.Types.AuthType do
  use Absinthe.Schema.Notation
  alias ScratchWeb.Resolvers.Auth
  import_types(ScratchWeb.Types.UserType)

  object :auth_mutations do
    @desc "Get Login"
    field :login, :login_success do
      arg(:username, :string)
      arg(:email, :string)
      arg(:password, non_null(:string))
      resolve(&Auth.login/3)
    end

    @desc "Get Register"
    field :register, :login_success do
      arg(:username, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password_one, non_null(:string))
      arg(:password_two, non_null(:string))
      resolve(&Auth.register/3)
    end
  end

  @desc "Login Successfull"
  object :login_success do
    field :id, :id
    field :token, :string
    field :user, :user
  end
end
