-- Collatz Conjecture

-- https://exercism.org/tracks/elm/exercises/collatz-conjecture/edit


module CollatzConjecture exposing (collatz)


collatz : Int -> Result String Int

collatz start =
    let
        recursion number counter =
            if (round number) == 1 then
                counter |> Ok
            else if (modBy 2 (round number)) == 0 then
                recursion ( number / 2) (counter + 1)   
            else 
                recursion ((number * 3) + 1) (counter + 1)
        floatStart = toFloat start
    in 
    if start <= 0 then
        Err "Only positive integers are allowed"
    else 
        recursion floatStart 0

-- jiegillet
-- https://exercism.org/tracks/elm/exercises/collatz-conjecture/solutions/jiegillet

module CollatzConjecture exposing (collatz)
collatz : Int -> Result String Int
collatz start =
  if start <= 0 then
    Err "Only positive integers are allowed"
  else
    Ok (steps start)
steps : Int -> Int
steps n =
  if n == 1 then
    0 
  else if modBy 2 n == 0 then
    1 + steps (n // 2)
  else
    2 + steps ((3 * n + 1) // 2)