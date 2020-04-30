defmodule Onfido.Resources.Document do
  alias Onfido.Comms.HttpDriver

  @doc """
  List documents for a given applicant.

  ## Example

        Onfido.Resources.Document.list("<applicant-id>")
  """
  def list(applicant_id) do
    HttpDriver.request(:get, "/documents?applicant_id=#{applicant_id}")
  end

  @doc """
  Get document for a given applicant.

  ## Example

        Onfido.Resources.Document.get("<applicant-id>", "<document-id>")
  """
  def get(applicant_id, document_id) do
    HttpDriver.request(:get, "/documents/#{document_id}", %{applicant_id: applicant_id})
  end

  @doc """
  Download document for a given applicant.

  ## Example

        Onfido.Resources.Document.download("<applicant-id>", "<document-id>")
  """
  def download(applicant_id, document_id) do
    HttpDriver.request(:get, "/documents/#{document_id}/download", %{applicant_id: applicant_id})
  end

  @doc """
  Upload document for a given applicant.

  ## Example

        Onfido.Resources.Document.update(%{
          applicant_id: "<applicant_id>",
          file: "...",
          type: "passport",
          side: "front",
          issuing_country: "GBP"
        })
  """
  def upload(params) do
    HttpDriver.request(:post, "/documents", params)
  end
end
