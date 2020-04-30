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

        Onfido.Resources.Check.get(%{applicant_id: "<applicant_id>")
  """
  def get(applicant_id, check_id) do
    HttpDriver.request(:get, "/checks/#{check_id}", %{applicant_id: applicant_id})
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

        Onfido.Resources.Check.resume("<applicant-id>", "<check-id>")
  """
  def resume(applicant_id, check_id, params \\ %{}) do
    HttpDriver.request(
      :post,
      "/checks/#{check_id}/resume",
      Map.merge(params, %{applicant_id: applicant_id})
    )
  end
end
