-- TRIANGLE
-- https://exercism.org/tracks/elm/exercises/triangle/edit

-- My Solution

module Triangle exposing (Triangle(..), triangleKind)


type Triangle
    = Equilateral
    | Isosceles
    | Scalene


triangleKind : number -> number -> number -> Result String Triangle
triangleKind x y z =
    if x <= 0 || y <= 0 || z <= 0 then
        Err "Invalid lengths"
    else if x + y <= z || y + z <= x || z + x <= y then
        Err "Violates inequality"
    else if x == y && y == z && z == x then
        Ok Equilateral
    else if x /= y && y /= z && z /= x then
        Ok Scalene
    else
        Ok Isosceles
    
-- Fryght 
-- https://exercism.org/tracks/elm/exercises/triangle/solutions/Fryght
module Triangle exposing (Triangle(..), triangleKind)
import Set
type Triangle
    = Equilateral
    | Isosceles
    | Scalene
triangleInequality : List number -> Bool
triangleInequality sides =
    (List.take 2 sides |> List.sum) < (List.drop 2 sides |> List.sum)
triangleKind : number -> number -> number -> Result String Triangle
triangleKind x y z =
    let
        inputAsList = [x, y, z]
        sortedList = inputAsList |> List.sort
    in
        if inputAsList |> List.any (\n -> n <= 0)
        then
            Err "Invalid lengths"
        else if triangleInequality sortedList
        then
            Err "Violates inequality"
        else
        case (Set.fromList(inputAsList) |> Set.size) of
            1 -> Ok Equilateral
            2 -> Ok Isosceles
            _ -> Ok Scalene
