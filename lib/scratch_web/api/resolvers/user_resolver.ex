defmodule ScratchWeb.Resolvers.Users do
  alias Scratch.Accounts

  def list_users(_args, %{context: %{current_user: current_user}}) do
    {:ok, Accounts.list_users()}
  end

  def list_users(_args, context) do
    IO.inspect(context.context)
    {:error, "Access denied"}
  end
end
