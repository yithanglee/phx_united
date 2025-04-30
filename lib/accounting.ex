defmodule Accounting do
  @endpoint Application.get_env(:united, :facebook)[:accounting_url]
  @sample_token "SFMyNTY.g2gDYQJuBgAy9xutfwFiAAFRgA.WKJMQoTw1YIc-1I4xZd3S9WDkyFdB_prJmF3Cxo3nvM"

  def request(name, params) do
    case name do
      "sales_users" ->
        nil
        get(params.scope, params.token)

      "debtor" ->
        nil
        post(Jason.encode!(params), params.token)
    end
  end

  def post(body, token) do
    HTTPoison.post("#{@endpoint}/united/api", body, [
      {"content-type", "application/json"},
      {"Authorization", "Bearer #{token}"}
    ])
  end

  def get(body, token) do
    HTTPoison.get("#{@endpoint}/united/api/#{body}", [
      {"content-type", "application/json"},
      {"Authorization", "Bearer #{token}"}
    ])
  end
end
