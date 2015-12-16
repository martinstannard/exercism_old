defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(list1, list2) do
    # compare length reduce to 1 sort of compare, pass in list type
    cond do
      length(list1) < length(list2) ->
        do_compare(list1, list2, :sublist)
      length(list1) == length(list2) ->
        do_compare(list2, list1, :equal)
      length(list1) > length(list2) ->
        do_compare(list2, list1, :superlist)
    end
  end

  defp do_compare(list1, list2, subtype) do
    case subby(list1, list2) do
      true -> subtype
      false -> :unequal
    end
  end

  defp subby(list1, list2), do: is_sub(list1, list2, list1, list2)

  defp is_sub([], _, _, _), do: true
  defp is_sub(_, [], _, _), do: false
  defp is_sub([h1|t1], [h2|t2], list1, [hl2|tl2]) do
    case h1 === h2 do
      true -> is_sub(t1, t2, list1, [hl2|tl2]) 
      _ -> is_sub(list1, tl2, list1, [h2|t2])
    end
  end
  defp is_sub(a, [h|_], _, _), do: a === h

end
