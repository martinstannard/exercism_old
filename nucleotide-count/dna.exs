defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    validate_base(nucleotide)
    strand |> Enum.map(&(validate_base(&1)))
    Enum.reduce(strand, 0, fn(x, acc) -> base_match(x, nucleotide) + acc end)
  end

  defp base_match(base, codon) do
    if base == codon do
      1
    else
      0
    end
  end

  defp validate_base(base) do
    unless Enum.member?([?A, ?C, ?G, ?T], base) do
      raise(ArgumentError, message: "Not a valid base")
    end
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.nucleotide_counts('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec nucleotide_counts([char]) :: Dict.t
  def nucleotide_counts(strand) do
    bases = [?A, ?T, ?C, ?G]
    counts = %{}
    bases
    |> Enum.reduce(counts, fn(b, acc) -> Dict.put(acc, b, count(strand, b) ) end)
  end
end
