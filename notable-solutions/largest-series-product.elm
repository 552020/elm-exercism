-- Largest Series Product
-- https://exercism.org/tracks/elm/exercises/largest-series-product

-- My Solution

module LargestSeriesProduct exposing (largestProduct)


largestProduct : Int -> String -> Maybe Int
largestProduct length series =
    let
        listOfDigits = String.toList series |> List.map (\x -> (Char.toCode x) - 48) 
        rangeIterator = List.range 1 ((String.length series) - (length - 1))
        substringsList = List.map (\x -> List.drop (x - 1) listOfDigits |> List.take length) rangeIterator
        listOfPairedProducts = List.map (\x -> Tuple.pair x (List.product x )) substringsList
        highestTuple = List.sortBy (\x -> Tuple.second x) listOfPairedProducts |> List.reverse |> List.take 1
        
    in
    if length == 0 
                then Just 1

    else if String.length series == 0 || 
            length < 0 ||
            not (String.all (Char.isDigit) series) 
                then Nothing
    else
        case List.head highestTuple of 
            Just (listSubstringInt, product) -> Just product 
            _ -> Nothing
   
-- https://exercism.org/tracks/elm/exercises/largest-series-product/solutions/jiegillet

module LargestSeriesProduct exposing (largestProduct)

largestProduct : Int -> String -> Maybe Int
largestProduct length string =
  if length < 0 || String.length string < length then
    Nothing 
  else if not (String.all Char.isDigit string) then
    Nothing
  else if length == 0 then
    Just 1
  else
    string
    |> String.toList 
    |> List.filterMap (String.fromChar >> String.toInt) 
    |> split length
    |> List.map List.product
    |> List.maximum

split : Int -> List a -> List (List a)
split n list =
  if List.length (List.take n list) < n then
    []
  else
    List.take n list :: split n (List.drop 1 list)

