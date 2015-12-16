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
    validate(nucleotide)
    strand
    |> Enum.map(&(validate(&1)))
    |> Enum.filter( &(&1 == nucleotide))
    |> length
  end

  defp validate(base) do
    if Enum.member?(@nucleotides, base) do
      base
    else
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
    @nucleotides
    |> Enum.reduce(%{}, fn(b, acc) -> Dict.put(acc, b, count(strand, b) ) end)
  end
end
