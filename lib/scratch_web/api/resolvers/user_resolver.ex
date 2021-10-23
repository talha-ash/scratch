defmodule ScratchWeb.Resolvers.Users do
  alias Scratch.Accounts

  def list_users(_args, _resolution) do
    {:ok, Accounts.list_users()}
  end

  def get_user(_args, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end
end
