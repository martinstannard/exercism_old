defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  4
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    counter(strand1, strand2, 0)
  end

  @spec counter([char], [char], non_neg_integer) :: non_neg_integer
  defp counter(strand, strand, count), do: count
  defp counter([], _, _), do: nil
  defp counter(_, [], _), do: nil
  defp counter([h1|t1], [h2|t2], count) do
    counter(t1, t2, count + count?(h1, h2))
  end

  @spec count?(char, char) :: non_neg_integer
  defp count?(base, base),   do: 0
  defp count?(base1, base2), do: 1
end
