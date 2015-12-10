defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    IO.puts "COMPARE"
    IO.puts inspect(a)
    IO.puts inspect(b)
    IO.puts "********"
    if length(a) > length(b) do
      IO.puts "sup"
      do_compare(b, a, true, false, b)
    else
      IO.puts "sub"
      do_compare(a, b, true, true, a)
    end
  end

  defp do_compare([h1|t1], [h2|t2], aligned, sub, list) do
    IO.puts inspect(h1)
    IO.puts inspect(h2)
    IO.puts inspect(list)
    IO.puts "-------"
    cond do
      h1 === h2 ->
        IO.puts "MATCHES"
        IO.puts inspect(t1)
        IO.puts inspect(t2)
        IO.puts "++++++++"
        do_compare(t1, t2, aligned, sub, list)
      true ->
        IO.puts "FAIL"
        IO.puts inspect(list)
        IO.puts inspect(t2)
        IO.puts "++++++++"
        do_compare(list, t2, false, sub, list)
    end
  end

  defp do_compare([], [], aligned, sub, _) do
    if aligned do
      :equal
    else
      sub_or_sup(sub)
    end
  end

  defp do_compare([h|t], [], _, sub, _) do
    IO.puts inspect(h)
    IO.puts inspect(t)
    IO.puts "array at start"
    :unequal
  end
  defp do_compare([a], [], _, _, _) do
    IO.puts inspect(a)
    IO.puts "element at start"
    :unequal
  end
  defp do_compare([nil], _, _, sub, _), do: sub_or_sup(sub)
  #defp do_compare([], [_a], _, _, _), do: :unequal
  defp do_compare([], _, _, sub, _), do: sub_or_sup(sub)


  defp sub_or_sup(true), do: :sublist
  defp sub_or_sup(false), do: :superlist

end
