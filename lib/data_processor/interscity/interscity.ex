defmodule DataProcessor.InterSCity do
  @moduledoc """
  The InterSCity context.
  """

  import Ecto.Query, warn: false
  alias DataProcessor.Repo

  alias DataProcessor.InterSCity.JobParams

  @doc """
  Returns the list of job_params.

  ## Examples

      iex> list_job_params()
      [%JobParams{}, ...]

  """
  def list_job_params do
    Repo.all(JobParams)
  end

  @doc """
  Gets a single job_params.

  Raises `Ecto.NoResultsError` if the Job params does not exist.

  ## Examples

      iex> get_job_params!(123)
      %JobParams{}

      iex> get_job_params!(456)
      ** (Ecto.NoResultsError)

  """
  def get_job_params!(id), do: Repo.get!(JobParams, id)

  @doc """
  Creates a job_params.

  ## Examples

      iex> create_job_params(%{field: value})
      {:ok, %JobParams{}}

      iex> create_job_params(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_job_params(attrs \\ %{}) do
    initial_spark_params = %{
      "schema" => %{},
      "publish_strategy" => %{"name" => "file", "format" => "csv"},
      "functional_params" => %{},
      "interscity" => %{}
    }

    attrs =
      attrs
      |> Map.put("spark_params", initial_spark_params)

    %JobParams{}
    |> JobParams.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a job_params.

  ## Examples

      iex> update_job_params(job_params, %{field: new_value})
      {:ok, %JobParams{}}

      iex> update_job_params(job_params, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_job_params(%JobParams{} = job_params, attrs) do
    job_params
    |> JobParams.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a JobParams.

  ## Examples

      iex> delete_job_params(job_params)
      {:ok, %JobParams{}}

      iex> delete_job_params(job_params)
      {:error, %Ecto.Changeset{}}

  """
  def delete_job_params(%JobParams{} = job_params) do
    Repo.delete(job_params)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking job_params changes.

  ## Examples

      iex> change_job_params(job_params)
      %Ecto.Changeset{source: %JobParams{}}

  """
  def change_job_params(%JobParams{} = job_params) do
    JobParams.changeset(job_params, %{})
  end

  def increase_scheduled_jobs(job_params) do
    changeset = change_job_params(job_params)
    scheduled_jobs = job_params.scheduled_jobs
    update_job_params(job_params, %{scheduled_jobs: scheduled_jobs + 1})
  end

  def alter_spark_param(job_params, command, table, key, value) do
    old_map = 
      job_params
      |> Map.get(:spark_params)
      |> Map.fetch!("#{table}")

    new_map =
      case command do
        :update -> Map.put(old_map, key, value)
        :remove -> Map.delete(old_map, key)
      end

    new_spark_params =
      job_params
      |> Map.get(:spark_params)
      |> Map.put(table, new_map)

    update_job_params(job_params, %{spark_params: new_spark_params})
  end
end