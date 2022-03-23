-- ANAGRAM

-- My solution

module Anagram exposing (detect)

import String exposing (toLower, fromList, toList)
import List exposing (filter, sort)


detect : String -> List String -> List String
detect word candidates =
    let 
        sorted w = toList (toLower w) 
                |> sort 
                |> fromList
    in
    filter (\x -> (sorted x == sorted word) && (toLower x /= toLower word)) candidates


-- https://exercism.org/tracks/elm/exercises/anagram/solutions/urgyen

normalize =
  String.toLower >> String.toList >> List.sort >> String.fromList
detect : String -> List String -> List String
detect word candidates =
  candidates
    |> List.filter (\x -> String.toLower x /= String.toLower word)
    |> List.filter (\x -> (normalize x) == (normalize word))
