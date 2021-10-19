# lib/graphql_tutorial_web/plugs/context.ex
defmodule ScratchWeb.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})

      _ ->
        conn
    end
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, user} <- authorize(token) do
      {:ok, %{current_user: user}}
    else
      _ -> %{}
    end
  end

  defp authorize(token) do
    case Scratch.Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        return_user(claims)

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp return_user(claims) do
    case Scratch.Guardian.resource_from_claims(claims) do
      {:ok, resource} -> {:ok, resource}
      {:error, reason} -> {:error, reason}
    end
  end
end
