-- HAMMING
-- https://exercism.org/tracks/elm/exercises/hamming/edit

-- My solution

module Hamming exposing (distance)


distance : String -> String -> Result String Int
distance left right =
    let 
        list string = String.toList string 
        listLeft = list left
        listRight = list right
    in
    if List.length listLeft /= List.length listRight then
        Err "strands must be of equal length"
    else
        List.map2 (\l r -> l == r) listLeft listRight
            |> List.filter (\b -> b == False)
            |> List.length
            |> Ok

-----------
-- stegrams       
-- https://exercism.org/tracks/elm/exercises/hamming/solutions/stegrams

module Hamming exposing (distance)
distance : String -> String -> Result String Int
distance left right =
    if String.length left /= String.length right then
        Err "strands must be of equal length"
    else
        String.toList right
            |> List.map2 (/=) (String.toList left)
            |> List.filter identity
            |> List.length
            |> Ok
