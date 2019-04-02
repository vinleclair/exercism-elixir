defmodule ProteinTranslation do
  @codons %{  
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP" 
  }
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    Regex.scan(~r/[A-Z]{3}/, rna <> "UAA") # append STOP to RNA
    |> Enum.reduce_while([], fn codon, acc -> 
      cond do
        elem(of_codon(hd(codon)), 0) == :error ->
          {:halt, {:error, "invalid RNA"}}
        elem(of_codon(hd(codon)), 1) == "STOP" ->
          {:halt, {:ok, acc}}
        true ->
          {:cont, acc ++ [elem(of_codon(hd(codon)), 1)]}
      end
    end)
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    if Map.has_key?(@codons, codon) do
      {:ok, Map.get(@codons, codon)}
    else
      {:error, "invalid codon"}
    end
  end
end
