defmodule Rex.Init do

  def initdb() do
    File.stream!("sensor_info_rex.csv")
    |> CSV.decode(headers: true)
    |> IO.inspect
    |> Enum.map(fn({:ok, x}) -> Rex.Sensors.Sensor.changeset(%Rex.Sensors.Sensor{}, x) end)
    |> IO.inspect
    |> Enum.each(fn(x) -> Rex.Repo.insert!(x) end)
  end
end
