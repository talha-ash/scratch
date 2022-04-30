defmodule Scratch.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Scratch.Repo

  alias Scratch.Accounts.User
  import Bcrypt, only: [verify_pass: 2, no_user_verify: 0]

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def user_auth(%{email: email, password: password}) do
    with {:ok, user} <- get_user(%{email: email}),
         {:ok, user} <- match_password(user, password) do
      {:ok, user}
    else
      {:error, message} ->
        {:error, message}
    end
  end

  def user_auth(%{username: username, password: password}) do
    with {:ok, user} <- get_user(%{username: username}),
         {:ok, user} <- match_password(user, password) do
      {:ok, user}
    else
      {:error, message} ->
        {:error, message}
    end
  end

  defp get_user(%{email: email}) do
    with %User{} = user <- Repo.get_by(User, email: email) do
      {:ok, user}
    else
      _nil ->
        no_user_verify()
        message = "Email Not Found"
        {:error, message}
    end
  end

  defp get_user(%{username: username}) do
    with %User{} = user <- Repo.get_by(User, username: username) do
      {:ok, user}
    else
      _nil ->
        no_user_verify()
        message = "Username Not Found"
        {:error, message}
    end
  end

  defp match_password(%User{} = user, password) do
    if verify_pass(password, user.password) do
      {:ok, user}
    else
      message = "invalid password"
      {:error, message}
    end
  end
end
