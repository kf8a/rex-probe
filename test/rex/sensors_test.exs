defmodule Rex.SensorsTest do
  use Rex.DataCase

  alias Rex.Sensors

  describe "sensors" do
    alias Rex.Sensors.Sensor

    import Rex.SensorsFixtures

    @invalid_attrs %{address: nil, barcode: nil, pakbus: nil, plot: nil}

    test "list_sensors/0 returns all sensors" do
      sensor = sensor_fixture()
      assert Sensors.list_sensors() == [sensor]
    end

    test "get_sensor!/1 returns the sensor with given id" do
      sensor = sensor_fixture()
      assert Sensors.get_sensor!(sensor.id) == sensor
    end

    test "create_sensor/1 with valid data creates a sensor" do
      valid_attrs = %{address: "some address", barcode: "some barcode", pakbus: "some pakbus", plot: "some plot"}

      assert {:ok, %Sensor{} = sensor} = Sensors.create_sensor(valid_attrs)
      assert sensor.address == "some address"
      assert sensor.barcode == "some barcode"
      assert sensor.pakbus == "some pakbus"
      assert sensor.plot == "some plot"
    end

    test "create_sensor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sensors.create_sensor(@invalid_attrs)
    end

    test "update_sensor/2 with valid data updates the sensor" do
      sensor = sensor_fixture()
      update_attrs = %{address: "some updated address", barcode: "some updated barcode", pakbus: "some updated pakbus", plot: "some updated plot" }

      assert {:ok, %Sensor{} = sensor} = Sensors.update_sensor(sensor, update_attrs)
      assert sensor.address == "some updated address"
      assert sensor.barcode == "some updated barcode"
      assert sensor.pakbus == "some updated pakbus"
      assert sensor.plot == "some updated plot"
    end

    test "update_sensor/2 with invalid data returns error changeset" do
      sensor = sensor_fixture()
      assert {:error, %Ecto.Changeset{}} = Sensors.update_sensor(sensor, @invalid_attrs)
      assert sensor == Sensors.get_sensor!(sensor.id)
    end

    test "delete_sensor/1 deletes the sensor" do
      sensor = sensor_fixture()
      assert {:ok, %Sensor{}} = Sensors.delete_sensor(sensor)
      assert_raise Ecto.NoResultsError, fn -> Sensors.get_sensor!(sensor.id) end
    end

    test "change_sensor/1 returns a sensor changeset" do
      sensor = sensor_fixture()
      assert %Ecto.Changeset{} = Sensors.change_sensor(sensor)
    end
  end
end
