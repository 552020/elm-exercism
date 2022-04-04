# Exercism - Sum of Multiples

First version:

```elm

multiples : List Int -> Int -> Int -> List Int
multiples myArray myInt myNewInt myLimit =
    case (myInt > myLimit) of
        True -> myArray
        False
            let
                myNewInt = myNewInt + myInt
            in
            multiples (myInt :: myArray) myInt myNewInt myLimit

```

## Second Try

```elm

multiples : List Int -> Int -> Int -> List Int
multiples myArray myMultiplier myProduct myLimit =
    case (myProduct > myLimit) of
        True -> myArray
        False
            multiples (myProduct :: myArray) myMultiplier (myProduct = myProduct + myMultiplier) myLimit

```

```bash
I ran into the = symbol unexpectedly in this pattern:

7|               multiples (myProduct :: myArray) myMultiplier (myProduct = myProduct + myMultiplier) myLimit

            ^
Only the :: symbol that works in patterns. It is useful if you are pattern
matching on lists, trying to get the first element off the front. Did you want
that instead?
```

## Third Try

```elm

multiples : List Int -> Int -> Int -> List Int
multiples myArray myMultiplier myProduct myLimit =
    case (myProduct > myLimit) of
        let myProduct = myProduct + myMultiplier
        in
        True -> myArray
        False
            multiples (myProduct :: myArray) myMultiplier myProduct myLimit

```

```bash
-- RESERVED WORD ---------------------------------------------------------- REPL

It looks like you are trying to use `let` in this pattern:

5|           let myProduct = myProduct + myMultiplier
             ^^^
This is a reserved word! Try using some other name?
```

## Fourth Try

```elm

multiples : List Int -> Int -> Int -> List Int
multiples myArray myMultiplier myProduct myLimit =

    let
        myProduct = myProduct + myMultiplier
    in

    case (myProduct > myLimit) of

        True -> myArray
        False ->
            multiples (myProduct :: myArray) myMultiplier myProduct myLimit

```

```elm
> sumOfMultiples : List Int -> Int -> List Int
sumOfMultiples divisors limit =
|     let
|         multiples myInt  =
|             let myMultiplier = myInt
|             in
|             if myInt >= limit then
|                 []
|             else
|                 myInt :: multiples (myInt + myMultiplier)
|     in
|     --List.sum (Set.toList (Set.fromList (List.concat (List.map multiples divisors))))
|     (List.concat (List.map multiples divisors))|
|
<function> : List Int -> Int -> List Int
> sumOfMultiples [5, 25] 51
[5,10,20,40,25,50]

```
