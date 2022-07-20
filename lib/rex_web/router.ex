defmodule RexWeb.Router do
  use RexWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RexWeb do
    pipe_through :api
    resources "/sensors", SensorController, except: [:new, :edit]
  end
end
