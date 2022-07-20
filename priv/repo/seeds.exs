# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rex.Repo.insert!(%Rex.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


File.stream!("sensor_info_rex.csv")
|> CSV.decode(headers: true)
|> IO.inspect
|> Enum.map(fn({:ok, x}) -> Rex.Sensors.Sensor.changeset(%Rex.Sensors.Sensor{}, x) end)
|> IO.inspect
|> Enum.each(fn(x) -> Rex.Repo.insert!(x) end)
