# Exercism

## Accumulate

The exercise is basically about writing a map function over a List from scratch.

```elm
module Accumulate exposing (accumulate)


accumulate : (a -> b) -> List a -> List b
accumulate func input =
    case input of
        [] -> []
        first :: rest ->
            (func first) :: accumulate func rest
    -- Debug.todo "Please implement this function"
```

I kind of got it but not completely.

## Grade School

About dictionaries

```elm

import Dict exposing (Dict)

users : Dict String User
users =
  Dict.fromList
    [ ("Alice", User "Alice" 28 1.65)
    , ("Bob"  , User "Bob"   19 1.82)
    , ("Chuck", User "Chuck" 33 1.75)
    ]

type alias User =
  { name : String
  , age : Int
  , height : Float
  }
```

## Robot Simulator

My Solution.

```elm
module RobotSimulator exposing
    ( Bearing(..)
    , Robot
    , advance
    , defaultRobot
    , simulate
    , turnLeft
    , turnRight
    )

type Bearing
    = North
    | East
    | South
    | West

type alias Robot =
    { bearing : Bearing
    , coordinates : { x : Int, y : Int }
    }

defaultRobot : Robot
defaultRobot =
    { bearing = North
    , coordinates = { x = 0, y = 0 }
    }

turnRight : Robot -> Robot
turnRight robot =
    let
        turnRightBearing =
            case robot.bearing of
                North -> East
                East -> South
                South -> West
                West -> North
    in
    { robot | bearing = turnRightBearing }

turnLeft : Robot -> Robot
turnLeft robot =
    let
        turnLeftBearing =
            case robot.bearing of
                North -> West
                East -> North
                South -> East
                West -> South
    in
    { robot | bearing = turnLeftBearing }


advance : Robot -> Robot
advance robot =
    case robot.bearing of
        North ->
            let
                previousCoordinates = robot.coordinates
                myY = robot.coordinates.y
            in
            { robot | coordinates = { previousCoordinates | y = myY + 1}}
        East ->
            let previousCoordinates = robot.coordinates
                myX = robot.coordinates.x
            in
            { robot | coordinates = { previousCoordinates | x = myX + 1}}
        South ->
            let previousCoordinates = robot.coordinates
                myY = robot.coordinates.y
            in
            { robot | coordinates = { previousCoordinates | y = myY - 1}}
        West ->
            let previousCoordinates = robot.coordinates
                myX = robot.coordinates.x
            in
            { robot | coordinates = { previousCoordinates | x = myX + 1}}

execute : Char -> Robot -> Robot
execute directionChar thisRobot =
            case directionChar of
                'A' -> advance thisRobot
                'L' -> turnLeft thisRobot
                'R' -> turnRight thisRobot
                _ -> thisRobot


simulate : String -> Robot -> Robot
simulate directions robot =
    let
        charList = String.toList directions
    in
    case charList of
        [] -> robot
        first :: rest ->
            execute first (simulate (List.foldl (++) "" (List.map (\x -> String.fromChar x) rest )) robot)
```

Topics:

- Update Nested Records
- Recursion

```elm

-- third try
simulate directions robot =
    let
        charList = String.toList directions
        execute directionChar thisRobot =
            case directionChar of
                'A' -> advance thisRobot
                'L' -> turnLeft thisRobot
                'R' -> turnRight thisRobot

        helperFunction
            case charList of
                [] -> robot
                first :: rest ->
                    execute first robot :: simulate (List.foldl (++) "" (List.map (\x -> String.fromChar x) rest )) robot
    in
    case List.head helperFunction of
        Nothing -> robot
        Just a -> a




    -- second try

    case charList of
        [] -> robot
        first :: rest ->
            case List.head (execute first robot :: simulate (List.foldl (++) "" (List.map (\x -> String.fromChar x) rest )) robot) of
                Nothing -> robot
                Just a -> a



    --first try
    -- this one gives us a list of robots
    --List.map (\x -> (execute x robot)) stringList
    --List.foldl (\x -> (execute x robot))  charList

```
# elm-exercism
