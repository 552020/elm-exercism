-- TWELVE DAYS

-- My Solution

module TwelveDays exposing (recite)


recite : Int -> Int -> List String
recite start stop =
    let 
        lyrics = "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree. On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree. On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree. On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree. On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree. On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree. On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree. On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree. On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree. On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree. On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree. On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    in
    String.replace "." ".\n" lyrics
        |> String.lines 
        |> List.filter (\x -> x /= "") 
        |> List.map (\x -> String.trim x)
        |> List.indexedMap (\x y -> if (x >= start - 1) && (x <= stop - 1) then y else "") 
        |> List.filter (\x -> x /= "")

{- LEARNINGS

- Array.slice, List.drop, List.take: Lists have no slice function but drop and take. Strings have slice and also Arrays.  

- List.map2

map2 : (a -> b -> result) -> List a -> List b -> List result
Combine two lists, combining them with the given function. If one list is longer, the extra elements are dropped.

totals : List Int -> List Int -> List Int
totals xs ys =
  List.map2 (+) xs ys

-- totals [1,2,3] [4,5,6] == [5,7,9]

pairs : List a -> List b -> List (a,b)
pairs xs ys =
  List.map2 Tuple.pair xs ys

-- pairs ["alice","bob","chuck"] [2,5,7,8]
--   == [("alice",2),("bob",5),("chuck",7)]



-}

-----
-- https://exercism.org/tracks/elm/exercises/twelve-days/solutions/leodeneo

recite start stop =
    let
        ords =
            ordinals |> List.drop (start - 1) |> List.take (stop - start + 1)
    in
    List.map2 songline (List.range start stop) ords
songline : Int -> String -> String
songline n ordinal =
    case n of
        1 ->
            "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
        _ ->
            let
                presentList =
                    presents
                        |> List.take n
                        |> List.reverse
                        |> String.join ", "
            in
            "On the " ++ ordinal ++ " day of Christmas my true love gave to me: " ++ presentList ++ "."
ordinals =
    [ "first"
    , "second"
    , "third"
    , "fourth"
    , "fifth"
    , "sixth"
    , "seventh"
    , "eighth"
    , "ninth"
    , "tenth"
    , "eleventh"
    , "twelfth"
    ]
presents =
    [ "and a Partridge in a Pear Tree"
    , "two Turtle Doves"
    , "three French Hens"
    , "four Calling Birds"
    , "five Gold Rings"
    , "six Geese-a-Laying"
    , "seven Swans-a-Swimming"
    , "eight Maids-a-Milking"
    , "nine Ladies Dancing"
    , "ten Lords-a-Leaping"
    , "eleven Pipers Piping"
    , "twelve Drummers Drumming"
    ]
    

    module TwelveDays exposing (recite)

-- buzykina
-- https://exercism.org/tracks/elm/exercises/twelve-days/solutions/buzykina
import Array exposing (fromList, slice, toList)
lyrics =
    [ "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
    , "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."
    , "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    , "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    , "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    , "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    , "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    , "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    , "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    , "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    , "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    , "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
    ]
recite : Int -> Int -> List String
recite start stop =
    slice (start - 1) stop (fromList lyrics) |> toList