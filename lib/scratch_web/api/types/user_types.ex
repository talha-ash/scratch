defmodule ScratchWeb.Types.UserType do
  use Absinthe.Schema.Notation

  @desc "A User"
  object :user do
    field :id, :id
    field :email, :string
    field :age, :string
    field :username, :string
  end
end
