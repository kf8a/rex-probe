defmodule RexWeb.SensorControllerTest do
  use RexWeb.ConnCase

  import Rex.SensorsFixtures

  alias Rex.Sensors.Sensor

  @create_attrs %{
    address: "some address",
    barcode: "some barcode",
    pakbus: "some pakbus",
    plot: "some replicate",
  }
  @update_attrs %{
    address: "some updated address",
    barcode: "some updated barcode",
    pakbus: "some updated pakbus",
    plot: "some updated replicate",
  }
  @invalid_attrs %{address: nil, barcode: nil, pakbus: nil, plot: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sensors", %{conn: conn} do
      conn = get(conn, Routes.sensor_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create sensor" do
    test "renders sensor when data is valid", %{conn: conn} do
      conn = post(conn, Routes.sensor_path(conn, :create), sensor: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.sensor_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "address" => "some address",
               "barcode" => "some barcode",
               "pakbus" => "some pakbus",
               "plot" => "some replicate",
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.sensor_path(conn, :create), sensor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update sensor" do
    setup [:create_sensor]

    test "renders sensor when data is valid", %{conn: conn, sensor: %Sensor{id: id} = sensor} do
      conn = put(conn, Routes.sensor_path(conn, :update, sensor), sensor: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.sensor_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "address" => "some updated address",
               "barcode" => "some updated barcode",
               "pakbus" => "some updated pakbus",
               "plot" => "some updated replicate",
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, sensor: sensor} do
      conn = put(conn, Routes.sensor_path(conn, :update, sensor), sensor: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete sensor" do
    setup [:create_sensor]

    test "deletes chosen sensor", %{conn: conn, sensor: sensor} do
      conn = delete(conn, Routes.sensor_path(conn, :delete, sensor))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.sensor_path(conn, :show, sensor))
      end
    end
  end

  defp create_sensor(_) do
    sensor = sensor_fixture()
    %{sensor: sensor}
  end
end
