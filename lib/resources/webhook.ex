defmodule Onfido.Resources.Webhook do
  alias Onfido.Comms.HttpDriver

  @doc """
  List webhooks

  ## Example

        Onfido.Resources.Webhook.list()
  """
  def list do
    HttpDriver.request(:get, "/webhooks")
  end

  @doc """
  Get a webhook

  ## Example

        Onfido.Resources.Webhook.get("<webhook-id>")
  """
  def get(webhook_id) do
    HttpDriver.request(:get, "/webhooks/#{webhook_id}")
  end

  @doc """
  Register a webhook

  ## Example

        Onfido.Resources.Webhook.register(%{
          url: "https://yourwebserver.com",
          enabled: true,
          environments: ["live", "sandbox"],
          events: [
            "report.completed",
            "check.completed"
          ]
        })
  """
  def register(params) do
    HttpDriver.request(:post, "/webhooks", params)
  end

  @doc """
  Verify signature on requests to Onfido webhook
  Based on https://developers.onfido.com/guide/manual-webhook-signature-verification

  Signature comparison requires raw_event_body as a string
  Once signature is verified it is safe to parse raw_event_body returned from this function

  # If using Plug, get raw_event_body and signature_header like so:

        {:ok, raw_event_body, conn} = read_body(conn)
        signature_header =
          get_req_header(conn, "X-SHA2-Signature")
          |> Base.decode64()
    
  ## Example

        Onfido.Resources.Webhook.verify_signature(webhook_token, signature_header, raw_event_body)
  """
  def verify_webhook_signature(webhook_token, signature_header, raw_event_body) do
    # Compute the HMAC using the SHA256 algorithm and using your webhook's token as the key.
    expected_signature = :crypto.hmac(:sha256, webhook_token, raw_event_body)

    # Must be a constant time comparison to prevent timing attacks - Elixir's pattern matching operations are constant time
    case {signature_header, expected_signature} do
      {equal, equal} -> {:ok, raw_event_body}
      {_, _} -> {:error, "invalid request signature on Onfido webhook"}
    end
  end
end
