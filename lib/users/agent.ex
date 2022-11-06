defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_link(%{}), do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def save(%User{} = user) do
    uuid = UUID.uuid4()
    Agent.update(__MODULE__, &update_state(&1, uuid, user))

    {:ok, uuid}
  end

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  defp get_user(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp update_state(state, uuid, %User{} = user), do: Map.put(state, uuid, user)
end
