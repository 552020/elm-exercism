-- Atbash Cipher

-- My solution

module AtbashCipher exposing (decode, encode)


encode : String -> String
encode plain =
    List.concatMap (\x -> (List.filter (\y -> Tuple.first y == x) pairedAlphabetWithNumbers )) (strList plain)
        |> List.map Tuple.second 
        |> String.fromList
        |> (\str -> List.map (\x -> String.slice (x * 5) ((x * 5) + 5) str) (List.range 0 ((String.length plain) // 5)))
        |> List.intersperse " "
        |> List.foldr (++) ""
        |> String.trim

-------------        
-- TechnoTone

-- c |> Char.toCode |> (-) 219 |> Char.fromCode

-- https://exercism.org/tracks/elm/exercises/atbash-cipher/solutions/TechnoTone

decode : String -> String
decode cipher =
      List.concatMap (\x -> (List.filter (\y -> Tuple.second y == x) pairedAlphabetWithNumbers )) (strList cipher)
        |> List.map Tuple.first 
        |> String.fromList
        |> String.trim

module AtbashCipher exposing (decode, encode)
encode : String -> String
encode plain =
    plain |> clean |> String.map transpose |> fragment
decode : String -> String
decode cipher =
    cipher |> clean |> String.map transpose
clean : String -> String
clean input =
    input
        |> String.map Char.toLower
        |> String.filter (\c -> Char.isLower c || Char.isDigit c)
transpose : Char -> Char
transpose c =
    if Char.isLower c then
        c |> Char.toCode |> (-) 219 |> Char.fromCode
    else
        c
split : List Char -> List (List Char)
split lst =
    if List.length lst <= 5 then
        [ lst ]
    else
        List.take 5 lst :: split (List.drop 5 lst)
fragment : String -> String
fragment =
    String.toList
        >> split
        >> List.map String.fromList
        >> String.join " "

--------------
-- moniquelive
-- https://exercism.org/tracks/elm/exercises/atbash-cipher/solutions/moniquelive

module AtbashCipher exposing (decode, encode)
rot26 : Char -> Char
rot26 c =
    if c >= 'a' && c <= 'z' then
        Char.toCode 'z'
            - (Char.toCode c - Char.toCode 'a')
            |> Char.fromCode
    else
        c
split : String -> String
split s =
    if String.length s < 5 then
        s
    else
        String.left 5 s ++ " " ++ split (String.dropLeft 5 s)
encode : String -> String
encode plain =
    String.toLower plain
        |> String.filter Char.isAlphaNum
        |> String.map rot26
        |> split
        |> String.trimRight
decode : String -> String
decode cipher =
    String.replace " " "" cipher
        |> String.map rot26
