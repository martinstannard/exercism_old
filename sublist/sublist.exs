defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(list1, list2) do
    cond do
      list1 == list2 -> :equal
      sublist?(list1, list2) -> :sublist
      sublist?(list2, list1) -> :superlist
      true -> :unequal
    end
  end

  defp sublist?(list1, list2), do: is_sub(list1, list2, list1, list2)

  defp is_sub([], _, _, _), do: true
  defp is_sub(_, [], _, _), do: false
  defp is_sub([h1|t1], [h2|t2], list1, [hl2|tl2]) do
    case h1 === h2 do
      true -> is_sub(t1, t2, list1, [hl2|tl2]) 
      _ -> is_sub(list1, tl2, list1, [h2|t2])
    end
  end

end
