defmodule LivecoinEx do
  @moduledoc """
  Livecoin api methods
  """
  use HTTPoison.Base

  @doc """
  Ticker response shape example
  %{ cur: "BTC",
    symbol: "BTC/EUR",
    last: 830.64858,
    high: 869.99,
    low: 787.4596,
    volume: 166.93894877,
    vwap: 825.99029209,
    max_bid: 869.99,
    min_ask: 51,
    best_bid: 807.148,
    best_ask: 850 }
  """
  def ticker() do
    "/exchange/ticker"
      |> get_and_extract()
  end

  def ticker(first, second) do
    first = String.upcase(first)
    second = String.upcase(second)
    "/exchange/ticker?currencyPair=#{first}/#{second}"
      |> get_and_extract()
  end

  defp get_and_extract(url) do
    url
      |> get()
      |> extract_body()
  end

  defp process_url(url) do
    "https://api.livecoin.net" <> url
  end

  def extract_body(result) do
    with {:ok, response} <- result,
      body = response.body,
      do: {:ok, body},
      else: ({:error, reason} -> {:error, reason})
  end

  defp process_request_body(body), do: body

  defp process_response_body(body) do
    body
    |> Poison.decode!
  end

  defp process_request_headers(headers) when is_map(headers) do
    Enum.into(headers, [])
  end

  defp process_request_headers(headers), do: headers

  defp process_response_chunk(chunk), do: chunk

  defp process_headers(headers), do: headers

  defp process_status_code(status_code), do: status_code

end
