defmodule Rex.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """
  @app :rex

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  def seed(file) do
    File.stream!(file)
    |> CSV.decode(headers: true)
    |> Enum.map(fn({:ok, x}) -> Rex.Sensors.Sensor.changeset(%Rex.Sensors.Sensor{}, x) end)
    |> Enum.each(fn(x) -> Rex.Repo.insert!(x) end)
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
