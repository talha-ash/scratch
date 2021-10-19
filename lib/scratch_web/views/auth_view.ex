defmodule ScratchWeb.AuthView do
  use ScratchWeb, :view
  alias ScratchWeb.AuthView

  def render("login.json", %{user: user, token: token}) do
    %{
      data: %{
        user: %{
          id: user.id,
          username: user.username,
          age: user.age,
          email: user.email
        },
        token: token
      }
    }
  end

  def render("register.json", %{user: user, token: token}) do
    %{
      data: %{
        id: user.id,
        username: user.username,
        age: user.age,
        email: user.email,
        token: token
      }
    }
  end
end
