defmodule Rex.Repo.Migrations.CreateSensors do
  use Ecto.Migration

  def change do
    create table(:sensors) do
      add :plot , :string
      add :address, :string
      add :pakbus, :string
      add :barcode, :string

      timestamps()
    end
  end
end
