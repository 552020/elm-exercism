# Result

## Exercism Syllabus - Result

### Lesson

`Result` is a type.

The `Result` type is defined like this:

```elm
type Result error value
  = Ok value
  | Err error
```

Why has been `Result` introduced.

```elm
isReasonableAge : String -> Result String Int
isReasonableAge input =
  case String.toInt input of
    Nothing ->
      Err "That is not a number!"

    Just age ->
      if age < 0 then
        Err "Please try again after you are born."

      else if age > 135 then
        Err "Are you some kind of turtle?"

      else
        Ok age

-- isReasonableAge "abc" == Err ...
-- isReasonableAge "-13" == Err ...
-- isReasonableAge "24"  == Ok 24
-- isReasonableAge "150" == Err ...
```

### Exercise

Start:

```elm
module Go exposing (..)

import GoSupport exposing (..)


applyRules : Game -> Rule -> NonValidatingRule -> Rule -> Rule -> Game
applyRules game oneStonePerPointRule captureRule libertyRule koRule =
    Debug.todo "Please implement the `applyRules` function"

```

```elm
module Go exposing (..)

import GoSupport exposing (..)


applyRules : Game -> Rule -> NonValidatingRule -> Rule -> Rule -> Game
applyRules game oneStonePerPointRule captureRule libertyRule koRule =
    if oneStonePerPointRule game == Err then
        Err "You broke the one stone per point rule!"
    else
        Ok game
-- Debug.todo "Please implement the `applyRules` function"

```

`applyRules : Game -> Rule -> NonValidatingRule -> Rule -> Rule -> Game`

What are `Game`. `Rule` and `Result`?

`Game` is a type alias for the type annotation of a specific record.
`Game` is not a variable holding a record, but hold only a Type Annotation.

```elm
type alias Game =
    { whiteCapturedStones : Int
    , blackCapturedStones : Int
    , player : Player
    , error : String
    }

type alias Rule =
    Game -> Result String Game


type Result error value
    = Ok value
    | Err error
```

`Rule` takes a `Game`, it means a record as an argument, and returns a `Result String Game`. `Result` is a type like `Bool`. If we would have `Bool` there we would have `True` or `False` as a return-value, and we should have handled both alternatives. `Result` is a data type, similar to `Maybe` but a value for both variants `Ok` and `Err`

`Ok` and `Error` as far I understand are Custom Types like:

```elm
type User
  = Regular String
  | Visitor String

thomas = Regular "Thomas"
kate95 = Visitor "kate95"
```

`OK` will wrap/have a `Game`
`Err` will wrap/have a `String`

```elm
case (oneStonePerPointRule game) of
        Err a -> { game | error = a}
        Ok newGame -> newGame
```

2. captureRule has another type `NonValidatingRule`. This is different than `Rule`. It takes a `Game` and returns a `Game`

```elm
type alias NonValidatingRule =
    Game -> Game
```
