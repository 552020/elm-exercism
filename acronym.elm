-- ACRONYM

-- My solution

module Acronym exposing (abbreviate)
abbreviate : String -> String
abbreviate phrase =
    String.words phrase 
        |> List.concatMap (String.split "-") 
        |> List.map (String.left 1) 
        |> List.foldr (++) "" 
        |> String.toUpper

-- Notable Solutios
-- #1
-- https://exercism.org/tracks/elm/exercises/acronym/solutions/probil

abbreviate phrase =
    phrase
        |> String.replace "-" " "
        |> String.words
        |> List.map (String.left 1 >> String.toUpper)
        |> String.concat

-- https://exercism.org/tracks/elm/exercises/acronym/solutions/damien-biasotto

abbreviate phrase =
    String.concat <|
        List.map String.toUpper <|
            List.map (\x -> String.slice 0 1 x) <|
                String.words <|
                    String.fromList <|
                        List.filter (\x -> x == ' ' || Char.isAlpha x) <|
                            String.toList <|
                                String.replace "-" " " phrase


-- https://exercism.org/tracks/elm/exercises/acronym/solutions/gbelmonte

import Char exposing (isAlpha, isUpper)
import List exposing (map)
import String exposing (all, concat, dropLeft, filter, left, replace, toUpper, words)

abbreviate : String -> String
abbreviate phrase =
    let
        capitalize string = (toUpper << left 1) string ++ dropLeft 1 string
        getLetters word =
            if all isUpper word then
                left 1 word
            else
                (filter isUpper << capitalize << filter isAlpha) word
    in
        phrase
            |> replace "-" " "
            |> words
            |> map getLetters
            |> concat

-- https://exercism.org/tracks/elm/exercises/acronym/solutions/Elm

abbreviate phrase =
    phrase
        |> String.replace "-" " "
        |> String.words
        |> List.filterMap (String.uncons >> Maybe.map Tuple.first)
        |> String.fromList
        |> String.toUpper


-- https://exercism.org/tracks/elm/exercises/acronym/solutions/pd9333

type alias Acc =
    { acronym : String, newWord : Bool }

abbreviate : String -> String
abbreviate phrase =
    let
        fold item { acronym, newWord } =
            if not (Char.isAlpha item) then
                { acronym = acronym, newWord = True }
            else if newWord then
                { acronym = acronym ++ [ item ], newWord = False }
            else
                { acronym = acronym, newWord = newWord }
    in
    String.toList phrase
        |> List.foldl fold { acronym = [], newWord = True }
        |> .acronym
        |> String.fromList
        |> String.toUpper


-- https://exercism.org/tracks/elm/exercises/acronym/solutions/pablobfonseca

removeDelimiters : String -> String
removeDelimiters =
    String.replace "-" " "
abbreviate : String -> String
abbreviate phrase =
    String.join "" (List.map (\x -> String.toUpper(String.left 1 x)) (String.split " " (removeDelimiters phrase)))


-- https://exercism.org/tracks/elm/exercises/acronym/solutions/eomanf

abbreviate phrase =
    phrase
        |> toAlphaWhitespace
        |> String.split " "
        |> List.map (head >> String.toUpper)
        |> String.concat

toAlphaWhitespace : String -> String
toAlphaWhitespace =
    let
        isAlphaWhitespace char =
            if Char.isAlpha char || char == ' ' then
                char
            else
                ' '
    in
    String.map isAlphaWhitespace

head : String -> String
head =
    String.left 1

-- https://exercism.org/tracks/elm/exercises/acronym/solutions/pwad

module Acronym exposing (abbreviate)
abbreviate : String -> String
abbreviate phrase =
    String.split " " phrase
        |> List.concatMap (\w -> String.split "-" w)
        |> List.filter (\w -> String.length w > 1)
        |> List.map (\s -> String.left 1 s)
        |> List.map (\s -> String.toUpper s)
        |> List.concatMap (\s -> String.toList s)
        |> String.fromList

-- https://exercism.org/tracks/elm/exercises/acronym/solutions/denisfalqueto

abbreviate phrase =
    phrase
        {- String -} |> String.words
        {- List String -} |> List.concatMap (String.split "-")
        {- List String -} |> List.map (String.left 1)
        {- List String -} |> String.concat
        {- String -} |> String.toUpper


-- https://exercism.org/tracks/elm/exercises/acronym/solutions/lilmspeppermint

abbreviate phrase =
    let
        p =
            String.filter
                (isPunctuation >> not)
                (String.replace "-" " " phrase)
        f : List String -> String
        f list =
            case list of
                [] ->
                    ""
                a :: rest ->
                    case String.uncons a of
                        Just ( x, _ ) ->
                            String.toUpper (String.cons x (f rest))
                        Nothing ->
                            ""
    in
    case p of
        "" ->
            ""
        _ ->
            f (String.words p)
isPunctuation : Char -> Bool
isPunctuation c =
    case c of
        '.' ->
            True
        ',' ->
            True
        '?' ->
            True
        '!' ->
            True
        ':' ->
            True
        ';' ->
            True
        '\'' ->
            True
        '(' ->
            True
        ')' ->
            True
        _ ->
            False

-- https://exercism.org/tracks/elm/exercises/acronym/solutions/Bernardoow

import Regex
splitSpaceOrHyphen : Regex.Regex
splitSpaceOrHyphen =
  Maybe.withDefault Regex.never <|
    Regex.fromString " |-"
abbreviate : String -> String
abbreviate phrase =
    Regex.split splitSpaceOrHyphen phrase
    |> List.map (\word -> String.left 1 word)
    |> String.join "" 
    |> String.toUpper

-- https://exercism.org/tracks/elm/exercises/acronym/solutions/correl

import Regex exposing (HowMany(All), regex, split)
abbreviate : String -> String
abbreviate phrase =
    split All (regex "[^a-zA-Z0-9]") phrase
        |> List.map (String.left 1)
        |> String.concat
        |> String.toUpper

-- https://exercism.org/tracks/elm/exercises/acronym/solutions/martinsvalin

import List exposing (map)
import String exposing (concat, left, replace, toUpper, words)
abbreviate : String -> String
abbreviate =
    toUpper >> replace "-" " " >> words >> map (left 1) >> concat
