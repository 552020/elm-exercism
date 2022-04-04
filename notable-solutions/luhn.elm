-- LUHN 
-- https://exercism.org/tracks/elm/exercises/luhn/

-- MY SOLUTION

module Luhn exposing (valid)


valid : String -> Bool
valid input =
    if input == "0" || input == " 0" then False
    else if String.any (\x -> (not ((Char.isDigit x) || (x == ' ')) )) input then False
    else
        String.toList input 
        |> List.filter Char.isAlphaNum 
        |> List.map (\x ->  Char.toCode x - 48) 
        |> List.reverse 
        |> List.indexedMap Tuple.pair 
        |> List.map  (\(x, y) -> if (modBy 2 x /= 0) then (x, (if ( y * 2 >= 10) then ((y * 2) - 9) else ( y * 2))) else(x, y))
        |> List.map Tuple.second|> List.sum 
        |> (\x -> modBy 10 x == 0)


