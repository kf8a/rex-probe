defmodule Rex.Sensors.Sensor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sensors" do
    field :address, :string
    field :barcode, :string
    field :pakbus, :string
    field :plot, :string

    timestamps()
  end

  @doc false
  def changeset(sensor, attrs) do
    sensor
    |> cast(attrs, [:plot, :address, :pakbus, :barcode])
    |> validate_required([:plot, :address, :pakbus, :barcode])
  end
end
