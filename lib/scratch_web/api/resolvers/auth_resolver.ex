defmodule ScratchWeb.Resolvers.Auth do
  alias Scratch.Accounts

  def login(_parent, args, _context) do
    with {:ok, %Accounts.User{} = user} <- Accounts.user_auth(args),
         {:ok, token, _claims} <- Scratch.Guardian.encode_and_sign(user) do
      {:ok, %{token: token, user: user}}
    else
      {:error, message} ->
        {:error, message}
    end
  end

  def register(_parent, args, _context) do
    with {:ok, %Accounts.User{} = user} <- Accounts.create_user(args),
         {:ok, token, _claims} <- Scratch.Guardian.encode_and_sign(user) do
      {:ok, %{token: token, user: user}}
    else
      {:error, message} ->
        {:error, message}
    end
  end
end
