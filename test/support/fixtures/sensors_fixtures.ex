defmodule Rex.SensorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rex.Sensors` context.
  """

  @doc """
  Generate a sensor.
  """
  def sensor_fixture(attrs \\ %{}) do
    {:ok, sensor} =
      attrs
      |> Enum.into(%{
        address: "some address",
        barcode: "some barcode",
        pakbus: "some pakbus",
        plot: "some replicate",
      })
      |> Rex.Sensors.create_sensor()

    sensor
  end
end
