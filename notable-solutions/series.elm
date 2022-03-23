-- SERIES

-- My solution

module Series exposing (slices)

import Char


slices : Int -> String -> Result String (List (List Int))
slices size input =
        let 
            length = String.length input
            inputToListInt = String.toList input |> List.map (\x -> (Char.toCode x) - 48) 
            recursion start list =
                if ((start + size) == length ) then
                    (List.take size (List.drop start list))  :: []
                else 
                    (List.take size (List.drop start list))  :: recursion (start + 1) list 
        in
        if length == 0 then
            Err "series cannot be empty"
        else if size > length then
             Err "slice length cannot be greater than series length"
        else if  size == 0 then
            Err "slice length cannot be zero"
        else if size < 0 then
            Err "slice length cannot be negative"
        else
            Ok (recursion 0 inputToListInt)

----------
-- USER163
-- https://exercism.org/tracks/elm/exercises/series/solutions/User163

module Series exposing (slices)

slices : Int -> String -> Result String (List (List Int))
slices size input =
    if (String.isEmpty input) then
        Err "series cannot be empty"
    else if (size == 0 ) then
        Err "slice length cannot be zero"
    else if (size < 0) then
        Err "slice length cannot be negative"
    else if(size > String.length input) then
        Err "slice length cannot be greater than series length"
    else
        Ok (List.map (\i -> toIntList i) (f size input))
    
  
f : Int -> String -> List (String)
f size input =
    if (String.length input > size) then
        (String.slice 0 size input) :: (f size (String.dropLeft 1 input))
    else 
        [input]
        
toIntList : String -> List Int
toIntList s =
  List.map (\c-> Maybe.withDefault 0 (String.toInt c)) (String.split "" s)


-- lauratrapani
-- https://exercism.org/tracks/elm/exercises/series/solutions/lauratrapani

module Series exposing (slices)
slices : Int -> String -> Result String (List (List Int))
slices size input =
    if input == "" then
        Err "series cannot be empty"
    else if size > (String.length input) then 
        Err "slice length cannot be greater than series length"
    else if size == 0 then
        Err "slice length cannot be zero"
    else if size < 0 then 
        Err "slice length cannot be negative"
    else createList size input |> Ok

createList : Int -> String -> List (List Int)
createList size input =
    calculateSlices 0 size input [] 
        |> List.map stringToListInt

calculateSlices : Int -> Int -> String -> List String -> List String
calculateSlices startIndex sliceSize input currentList=
    if (checkIfBreak startIndex sliceSize input) then 
        currentList
    else sliceSize + startIndex 
            |> setCurrentList input currentList startIndex 
            |> calculateSlices (startIndex + 1) sliceSize input 

setCurrentList : String -> List String -> Int -> Int -> List String
setCurrentList input list startIndex endIndex =
    list ++ [ String.slice startIndex endIndex input ]

checkIfBreak : Int -> Int -> String -> Bool
checkIfBreak startIndex sliceSize input = 
    startIndex > ((String.length input) - sliceSize )

stringToListInt : String -> List Int
stringToListInt str =
    String.toList str |> List.map charToInt

charToInt : Char -> Int
charToInt char =
    String.fromChar char 
        |> String.toInt 
        |> Maybe.withDefault 0
        
-- Elm
-- https://exercism.org/tracks/elm/exercises/series/solutions/Elm
module Series exposing (slices)
slices : Int -> String -> Result String (List (List Int))
slices size input =
    if size < 0 then
        Err "slice length cannot be negative"
    else if size == 0 then
        Err "slice length cannot be zero"
    else if String.length input == 0 then
        Err "series cannot be empty"
    else if String.length input < size then
        Err "slice length cannot be greater than series length"
    else
        List.range 0 (String.length input - size)
            |> List.map
                (\i ->
                    String.slice i (i + size) input
                        |> String.toList
                        |> List.map String.fromChar
                        |> List.filterMap String.toInt
                )
            |> Ok

-- Damien Bisotto
-- https://exercism.org/tracks/elm/exercises/series/solutions/damien-biasotto

module Series exposing (slices)
import List
import Array
import String exposing (String(..))
slices : Int -> String -> Result String (List (List Int))
slices size input =
    if String.length input == 0 then
        Err "series cannot be empty"
    else if size < 0 then
        Err "slice length cannot be negative"
    else if size == 0 then
        Err "slice length cannot be zero"
    else if size > String.length input then
        Err "slice length cannot be greater than series length"
    else
        let
            slice : Int -> List Int -> List (List Int) -> Result String (List (List Int))
            slice x xs acc =  
                case xs of 
                    [] -> Ok acc
                    _ -> if (List.length xs) >= x then
                            slice x (List.drop 1 xs) ( acc ++ [(Array.toList <| Array.slice 0 x <| Array.fromList xs)])
                        else
                            Ok acc
        in
            slice size (List.filterMap String.toInt (List.map String.fromChar (String.toList input))) []
-- psiphi75
-- https://exercism.org/tracks/elm/exercises/series/solutions/psiphi75
module Series exposing (slices)
toInt : String -> Int
toInt str =
    case String.toInt str of
        Just i -> i
        Nothing -> 0
slice : Int -> List Int -> List (List Int) 
slice size ints =
    let
        head = List.take size ints
        tail = List.drop 1 ints
    in
    if List.length tail >= size then
        [head] ++ (slice size tail)
    else
        [ints]
slices : Int -> String -> Result String (List (List Int))
slices size input =
    let
        len = String.length input
    in
    if len == 0 then
        Err "series cannot be empty"
    else if size > len then
        Err "slice length cannot be greater than series length"
    else if size == 0 then
        Err "slice length cannot be zero"
    else if size < 0 then
        Err "slice length cannot be negative"
    else
        let
            num = len // size
            ints = input
                |> String.split ""
                |> List.map toInt
        in
        Ok (slice size ints)