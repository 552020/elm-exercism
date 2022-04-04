-- PYTHAGOREAN TRIPLE

--First Try

module PythagoreanTriplet exposing (triplets)


type alias Triplet =
    ( Int, Int, Int )

triplets : Int -> List Triplet
triplets n =
    let 
        range = List.range 0 n
        bigList = List.concatMap (\x -> List.concatMap (\y -> List.map (\z -> [x,y,z]) range) range) range
        sumList = List.filter (\x -> (List.sum x) == n) bigList
        powerList = case List.filter(\[x, y, z] -> (x * x) + (y * y) == z * z) sumList of
            [] -> [[0, 0, 0]]
            ([x, y, z] :: rest) -> [x, y, z] :: rest
            [] :: _ -> [[0, 0, 0], [0, 0, 0] ]
            
        lessThanList = List.filter (\[x, y, z] -> x < y && y < z) powerList
    in
    List.map (\[first, second, third] -> (first, second, third) ) lessThanList

-- Second try

module PythagoreanTriplet exposing (triplets)

import Set

type alias Triplet =
    ( Int, Int, Int )

triplets : Int -> List Triplet
triplets n =
    recursionC 1 2 3 n 
    |> List.concatMap (\(x, y, z) -> recursionB x y z n) 
    |> List.map (\(x, y, z) -> noRecursionA x y z n)
    |> Set.fromList 
    |> Set.toList
    |> List.filter (\(x, y, z) -> ((x * x) + (y * y) == z * z) && x /= 0)

recursionC a b c n =
    if c >= n - a - b then     
        [(a, b, c)]
    else 
        (a, b, c) :: recursionC a b (c + 1) n

recursionCFoldl a b c n =
    if c >= n - a - b then     
        [(a, b, c)]
    else 
        let 
            buildTripletsIncrementingC i acc =
                (a, b, (c + i) :: acc
        in 
        List.range 1 (n - b - a)
            |> List.foldl buildTripletsIncrementingC []


recursionB a b c n =
    if (c - 2) + (c - 1) + c < n then
        [(0,0,0)]
    else
        if b >= n - c - a then 
            [(a, b, c)]
        else 
            (a, b, c) :: recursionB a (b + 1) c n

recursionBFoldl a b c n =
    if (c - 2) + (c - 1) + c < n then
        [(0,0,0)]
    else
        let 
            buildTripletsIncrementingB i acc =
                (a, (b + n ), c) :: i
        in 
        List.range 1 (n - c - a)
            |> List.foldl buildTripletsIncrementingB []

{-
recursionA a b c n =
    if a + b + c == n then
        (a, b, c)
    else if (a >= b) && a + b + c < n then
        (0, 0, 0)
    else
        recursionA (a + 1) b c n
        
-}
noRecursionA a b c n =
    if (n - c - b) < b then
        (n - c - b, b, c)
    else
        (0, 0, 0)

-- Third try

-- 1. We find all the factors of N divided by 2
-- a + b + c = 2 (m*m) + 2mn = 2m(m + n)
-- a + b + c = 2m (m + n) 
-- (a + b + c) / 2 = m (m + b)
triples n =
    let 
        factors = List.range 1 (n // 2)
            |> List.filter (\x -> (modBy x (modBy x n)) == 0)
    in
    List.concatMap (\x -> List.map (\y -> if  x * y == n then Tuple.pair x y else (0,0)) factors) factors 
        |> Set.fromList 
        |> Set.toList 
        |> List.filter (\(x,y) -> (x - y) > 0 && (x - y) < y )
        |> List.map (\(x,y) -> Tuple.pair (x - y) y)
        |> List.map (\(y, x) -> (((x * x) - (y * y)), (2 * x * y), ((x * x) + (y * y))))





{- second try and refactoring
triplets n =
    let 
        customN = 10000
    in
    List.range 1 customN
        |> List.concatMap (\x -> List.map (\ y -> Tuple.pair x  y)( List.range (x + 1) customN) ) 
        |> List.filter (\(y, x) -> (((x * x) - (y * y)) + (2 * x * y) + ((x * x) + (y * y))) == n)
        |> List.map (\(y, x) -> (((x * x) - (y * y)), (2 * x * y), ((x * x) + (y * y))))