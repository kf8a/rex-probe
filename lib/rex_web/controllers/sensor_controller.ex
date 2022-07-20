defmodule RexWeb.SensorController do
  use RexWeb, :controller

  alias Rex.Sensors
  alias Rex.Sensors.Sensor

  action_fallback RexWeb.FallbackController

  def index(conn, _params) do
    sensors = Sensors.list_sensors()
    render(conn, "index.json", sensors: sensors)
  end

  def create(conn, %{"sensor" => sensor_params}) do
    with {:ok, %Sensor{} = sensor} <- Sensors.create_sensor(sensor_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.sensor_path(conn, :show, sensor))
      |> render("show.json", sensor: sensor)
    end
  end

  def show(conn, %{"id" => id}) do
    # sensor = Sensors.get_sensor!(id)
    sensor = Sensors.get_sensor_by_barcode(id)
    render(conn, "show.json", sensor: sensor)
  end

  def update(conn, %{"id" => id, "sensor" => sensor_params}) do
    sensor = Sensors.get_sensor!(id)

    with {:ok, %Sensor{} = sensor} <- Sensors.update_sensor(sensor, sensor_params) do
      render(conn, "show.json", sensor: sensor)
    end
  end

  def delete(conn, %{"id" => id}) do
    sensor = Sensors.get_sensor!(id)

    with {:ok, %Sensor{}} <- Sensors.delete_sensor(sensor) do
      send_resp(conn, :no_content, "")
    end
  end
end
