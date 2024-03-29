defmodule Onfido.Comms.HttpDriver do
  def request(:delete, path) do
    path
    |> api_url()
    |> HTTPoison.delete(headers(), options())
    |> decode_json()
  end

  def request(method, path, params \\ %{})

  def request(:get, path, params) do
    url_params = params |> URI.encode_query()
    string = if url_params == "", do: "#{path}", else: "#{path}?#{url_params}"

    string
    |> api_url()
    |> HTTPoison.get(headers(), options())
    |> decode_json()
  end

  def request(:post, path, params) do
    {:ok, payload} = FormData.create(params, :url_encoded)

    path
    |> api_url()
    |> HTTPoison.post(payload, headers(), options())
    |> decode_json()
  end

  def request(:put, path, params) do
    {:ok, payload} = FormData.create(params, :url_encoded)

    path
    |> api_url()
    |> HTTPoison.put(payload, headers(), options())
    |> decode_json()
  end

  defp api_url(url) do
    api_base() <> url
  end

  defp headers do
    [
      Authorization: "Token token=#{api_token()}"
    ]
  end

  defp options do
    [ssl: [{:versions, [:"tlsv1.2"]}]]
  end

  defp decode_json({:ok, resp_map}) do
    case resp_map.body do
      "" -> {:ok, "No Body"}
      body -> Poison.decode(body)
    end
    |> create_response(resp_map)
  end

  defp decode_json({:error, error}) do
    case error do
      "" -> {:error, "Something went wrong"}
      e -> Poison.decode(e)
    end
  end

  defp create_response({:ok, body}, resp_map) do
    case resp_map.status_code do
      x when x in [200, 201, 204] ->
        {:ok, body}

      _ ->
        {:error, body}
    end
  end

  defp create_response({:error, _}, _), do: {:error, "There was an issue decoding the body"}

  defp api_token, do: Application.fetch_env!(:onfido_v3, :api_token)
  defp api_base, do: Application.fetch_env!(:onfido_v3, :api_base)
end
