defmodule Teenager do
  def hey(input) do
    cond do
      Regex.match?(~r/^ *$/, input) -> "Fine. Be that way!"
      Regex.match?(~r/[A-Z\s]+!{0,1}$/, input) -> "Woah, chill out!"
      Regex.match?(~r/[A-Z][^a-z]\s]!$/, input) -> "Woah, chill out!"
      Regex.match?(~r/[A-Za-z\s]!$/, input) -> "Whatever."
      Regex.match?(~r/[A-Za-z\-\s]\.$/, input) -> "Whatever."
      Regex.match?(~r/\d+\?$/, input) -> "Sure."
      Regex.match?(~r/[\d\s,]+[A-Z]+!$/, input) -> "Woah, chill out!"
      Regex.match?(~r/[\d\s,]+$/, input) -> "Whatever."
      Regex.match?(~r/\?$/, input) -> "Sure."
      Regex.match?(~r/[A-Za-z\s]+\?[A-Za-z\s]+\.$/, input) -> "Whatever."
      input -> "Woah, chill out!"
    end
  end
end
