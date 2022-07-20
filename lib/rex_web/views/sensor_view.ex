defmodule RexWeb.SensorView do
  use RexWeb, :view
  alias RexWeb.SensorView

  def render("index.json", %{sensors: sensors}) do
    %{data: render_many(sensors, SensorView, "sensor.json")}
  end

  def render("show.json", %{sensor: sensor}) do
    %{data: render_one(sensor, SensorView, "sensor.json")}
  end

  def render("sensor.json", %{sensor: sensor}) do
    %{
      id: sensor.id,
      plot: sensor.plot,
      address: sensor.address,
      pakbus: sensor.pakbus,
      barcode: sensor.barcode
    }
  end
end
