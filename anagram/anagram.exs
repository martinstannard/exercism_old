defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates
    |> Enum.filter( &(sort(&1) == sort(base)) )
    |> Enum.filter( &(String.downcase(&1) != String.downcase(base)) )
  end

  def sort(word) do
    word |> String.downcase |> String.to_char_list |> Enum.sort
  end
end
