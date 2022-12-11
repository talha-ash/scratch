defmodule ScratchWeb.Resolvers.Auth do
  alias Scratch.Accounts

  def login(_parent, args, _context) do
    with {:ok, %Accounts.User{} = user} <- Accounts.user_auth(args),
         {:ok, access_token, refresh_token, exp} <- generate_tokens(user),
         {:ok, _user} <- Accounts.set_refresh_token(%{user: user, refresh_token: refresh_token}) do
      {:ok, %{access_token: access_token, refresh_token: refresh_token, user: user, exp: exp}}
    else
      {:error, message} ->
        {:error, message}
    end
  end

  def register(_parent, args, _context) do
    with {:ok, %Accounts.User{} = user} <- Accounts.create_user(args),
         {:ok, access_token, refresh_token, exp} <- generate_tokens(user),
         {:ok, _user} <- Accounts.set_refresh_token(%{user: user, refresh_token: refresh_token}) do
      {:ok, %{access_token: access_token, refresh_token: refresh_token, user: user, exp: exp}}
    else
      {:error, message} ->
        {:error, message}
    end
  end

  def refresh_token(_parent, %{refresh_token: refresh_token}, _context) do
    with {:ok, user} <- Accounts.verify_refresh_token(refresh_token),
         {:ok, access_token, refresh_token, exp} <- generate_tokens(user),
         {:ok, _user} <- Accounts.set_refresh_token(%{user: user, refresh_token: refresh_token}) do
      {:ok, %{access_token: access_token, refresh_token: refresh_token, exp: exp}}
    else
      {:error, %{user_id: user_id}} ->
        Accounts.remove_refresh_token(user_id)
        {:error, "token_expired"}

      {:error, message} ->
        {:error, message}
    end
  end

  defp generate_tokens(user) do
    with {:ok, access_token, %{"exp" => exp}} <-
           Scratch.Guardian.encode_and_sign(user, %{}, ttl: {1, :minute}),
         {:ok, refresh_token, _claims} <-
           Scratch.Guardian.encode_and_sign(user, %{}, token_type: "refresh", ttl: {5, :minute}) do
      {:ok, access_token, refresh_token, exp}
    else
      {:error, message} ->
        {:error, message}
    end
  end
end
