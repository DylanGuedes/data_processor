defmodule DataProcessorWeb.Router do
  use DataProcessorWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", DataProcessorWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/start_job", JobController, :start_job)
    get("/fade_job", JobController, :fade_job)
    resources("/job_params", JobParamsController, only: [:index, :show, :new, :create, :edit])
    resources("/jobs", JobController, only: [:index])
    resources("/handlers", HandlerController, only: [:index])
    post("/add_schema_field", JobParamsController, :add_schema_field)
    post("/add_interscity_field", JobParamsController, :add_interscity_field)
    post("/add_functional_field", JobParamsController, :add_functional_field)
    post("/update_publish_strategy", JobParamsController, :update_publish_strategy)
    get("/remove_schema_field", JobParamsController, :remove_schema_field)
    get("/remove_interscity_field", JobParamsController, :remove_interscity_field)
    get("/remove_functional_field", JobParamsController, :remove_functional_field)
    get("/schedule_spark_job", JobParamsController, :schedule_spark_job)
    get("/remove_job", JobParamsController, :remove_job)
    get("/clone", JobParamsController, :clone)
  end

  scope "/api", DataProcessorWeb do
    pipe_through(:api)

    post("/register_job", API.JobController, :register_job)
    post("/jobs/spawn_spark_job", API.JobController, :spawn_spark_job)
    get("/retrieve_params", API.JobController, :retrieve_params)
    get("/start_job", API.JobController, :start_job)
    get("/retrieve_log", API.JobController, :retrieve_log)
    resources("/jobs", API.JobController, only: [:index])
    resources("/templates", API.TemplatesController, only: [:index])
  end
end