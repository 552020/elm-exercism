-- https://exercism.org/tracks/elm/exercises/nucleotide-count/edit
-- MY SOLUTION

module NucleotideCount exposing (nucleotideCounts)


type alias NucleotideCounts =
    { a : Int
    , t : Int
    , c : Int
    , g : Int
    }


nucleotideCounts : String -> NucleotideCounts
nucleotideCounts sequence =
    String.toLower sequence
        |> String.toList 
        |> List.foldl (\x -> countNucleotide x) { a = 0, t = 0, c = 0, g = 0}

countNucleotide : Char -> NucleotideCounts -> NucleotideCounts
countNucleotide myChar myNucleotideCounts =
    case myChar of
        'a' -> {myNucleotideCounts | a = myNucleotideCounts.a + 1}
        't' -> {myNucleotideCounts | t = myNucleotideCounts.t + 1}
        'c' -> {myNucleotideCounts | c = myNucleotideCounts.c + 1}
        'g' -> {myNucleotideCounts | g = myNucleotideCounts.g + 1}
        _ -> myNucleotideCounts
