defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map()
  def count(sentence) do
    String.split(String.downcase(sentence), [" ", "_"])
    |> Enum.map( &clean/1 )
    |> Enum.filter( &(&1) )
    |> Enum.reduce(%{}, &count_word/2)
  end

  def clean(word) do
    r = Regex.run(~r/[\w\d-]+/u, word)
    case r do
      nil -> nil
      _ -> Enum.at(r, 0)
    end
  end

  def count_word(word, accum) do
    Dict.update(accum, word, 1, fn(val) -> val + 1 end)
  end

end
