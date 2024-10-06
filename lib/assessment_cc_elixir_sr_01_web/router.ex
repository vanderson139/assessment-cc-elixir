defmodule AssessmentCcElixirSr01Web.Router do
  use AssessmentCcElixirSr01Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AssessmentCcElixirSr01Web do
    pipe_through :api
    resources "/monsters", MonsterController, only: [:index, :show, :create, :update, :delete]
    post "/monster-import-csv", MonsterController, :import
    resources "/battles", BattleController, only: [:index, :show, :create, :delete]
  end
end
