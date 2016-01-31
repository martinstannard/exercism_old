defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(Dict.t) :: map()
  def transform(input) do
    Enum.reduce(input, %{}, &transform_key(&1, &2))
  end

  defp transform_key({key, words}, map) do
    Enum.reduce(words, map, &Map.put(&2, String.downcase(&1), key))
  end
end
