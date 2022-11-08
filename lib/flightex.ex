defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookinsAgent
  alias Flightex.Bookings.CreateOrUpdate, as: CreateOrUpdateBookings
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate, as: CreateOrUpdateUsers

  def start_agents do
    UserAgent.start_link(%{})
    BookinsAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params), to: CreateOrUpdateUsers, as: :call
  defdelegate create_or_update_booking(params), to: CreateOrUpdateBookings, as: :call
end
