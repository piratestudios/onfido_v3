defmodule Onfido.Resources.Check do
  alias Onfido.Comms.HttpDriver

  @doc """
  List checks for an applicant

  ## Example

        Onfido.Resources.Check.list("<applicant-id>")
  """
  def list(applicant_id) do
    HttpDriver.request(:get, "/checks", %{applicant_id: applicant_id})
  end

  @doc """
  Get a check for an applicant

  ## Example

        Onfido.Resources.Check.get("<check_id>")
  """
  def get(check_id) do
    HttpDriver.request(:get, "/checks/#{check_id}")
  end

  @doc """
  Create a check for an applicant

  ## Example

        Onfido.Resources.Check.create(%{
          applicant_id: "<applicant_id>",
          report_names: [
            "document",
            "facial_similarity_photo"
          ]
        })
  """
  def create(params) do
    HttpDriver.request(:post, "/checks", params)
  end

  @doc """
  Resume a check for an applicant

  ## Example

        Onfido.Resources.Check.resume("<check-id>")
  """
  def resume(check_id, params \\ %{}) do
    HttpDriver.request(
      :post,
      "/checks/#{check_id}/resume",
      Map.merge(params)
    )
  end
end
