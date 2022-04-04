words = String.words "one fish two fish red fish blue fish"
wordsTuples = List.map (\x -> (x, 1)) words 
List.map (\x -> List.foldl (\y z -> if x == y then (x , z + 
1)) 0

myFoldl (x, y) (j, k) =
    if x == j then 
        (j, (k + 1))
    else (j, k)

List.map (\x -> List.foldl myFoldl (x, 0)  wordsTuples  ) words 
 List.map (\x -> List.foldl myFoldl (x, 0)  wordTuples  ) words |> Set.fromList |> Set.toList