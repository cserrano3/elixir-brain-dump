defmodule Identicon do
  def main(input) do
    input
    |> hashString
    |> pickColor
    |> buildGrid
  end

  def buildGrid(imageStruct) do

    %Identicon.Image{ hex: hexList } = imageStruct
    IO.inspect(hexList)
    hexList
    |> Enum.chunk_every(3, 3, :discard)
    |> Enum.map(&mirrorRow/1) #defines reference to mirrorRow function with arity of one.
  end

  def mirrorRow(hexRow) do
    IO.inspect(hexRow)
#    Identicon.main("ohh sweet love")
#     HexGrid
#    [
#      [13, 77, 184],
#      [56, 143, 224],
#      [102, 190, 14],
#      [211, 14, 231],
#      [179, 90, 36],
#      [231]
#
#      [13, 77, 184] must become [13,77,184,77,13]

  [first, second | _tail] = hexRow
  hexRow ++ [second, first] # ++ stands to append
  end

  def hashString(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{hex: hex}
  end
  # pattern matching is used to destructure the hexList variable from the imageStruct parameter
  # yes, destructuring can also be done in the function signature
  def pickColor( %Identicon.Image{ hex: [ red, green, blue | _tail ] } = imageStruct) do
    %Identicon.Image{ imageStruct | color: { red, green, blue }}
  end
end
