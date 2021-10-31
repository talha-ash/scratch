defmodule ScratchWeb.AuthController do
  use ScratchWeb, :controller
  alias Scratch.{Accounts, Guardian}
  alias Scratch.Accounts.User

  def login(conn, login_params) do
    with {:ok, %User{} = user} <- Accounts.user_auth(login_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:accepted)
      |> render("login.json", %{user: user, token: token})
    else
      {:error, message} ->
        conn
        |> put_view(ScratchWeb.ErrorView)
        |> render("login_error.json", message: message)
    end
  end

  def register(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("register.json", %{user: user, token: token})
    end
  end
end
