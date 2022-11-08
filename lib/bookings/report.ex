defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def generate(filename) do
    lines = build_lines()

    File.write!(filename, lines)

    {:ok, "Booking report successfully generated!"}
  end

  defp build_lines() do
    BookingAgent.get_all()
    |> Enum.map(&create_line/1)
  end

  defp create_line(
         {_booking_uuid,
          %Booking{
            user_id: user_id,
            local_origin: local_origin,
            local_destination: local_destination,
            complete_date: complete_date
          }}
       ) do
    "#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end
end
