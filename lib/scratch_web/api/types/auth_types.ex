defmodule ScratchWeb.Types.AuthType do
  use Absinthe.Schema.Notation
  import_types(ScratchWeb.Types.UserType)

  @desc "Login Successfull"
  object :login_success do
    field :id, :id
    field :token, :string
    field :user, :user
  end
end
