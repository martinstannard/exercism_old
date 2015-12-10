defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    if length(a) > length(b) do
      do_compare(b, a, true, false, b)
    else
      do_compare(a, b, true, true, a)
    end
  end

  defp do_compare([], [], aligned, sub, _) do
    if aligned do
      :equal
    else
      sub_or_sup(sub)
    end
  end

  defp do_compare([], _, _, sub, _), do: sub_or_sup(sub)
  defp do_compare([nil], _, _, sub, _), do: sub_or_sup(sub)

  defp do_compare([a], [], _, _, _), do: :unequal
  defp do_compare([h|t], [], _, sub, _), do: sub_or_sup(sub)

  defp do_compare([h1|t1], [h2|t2], aligned, sub, list) do
    cond do
      h1 === h2 ->
        do_compare(t1, t2, aligned, sub, list)
      true ->
        do_compare(list, t2, false, sub, list)
    end
  end

  defp sub_or_sup(true), do: :sublist
  defp sub_or_sup(false), do: :superlist

end
