-- ROBOT SIMULATOR
-- https://exercism.org/tracks/elm/exercises/robot-simulator/edit

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
                North ->
                    East
                East ->
                    South
                South ->
                    West
                West ->
                    North
    in
    { robot | bearing = turnRightBearing }
turnLeft : Robot -> Robot
turnLeft robot =
    let
        turnLeftBearing =
            case robot.bearing of
                North ->
                    West
                East ->
                    North
                South ->
                    East
                West ->
                    South
    in
    { robot | bearing = turnLeftBearing }
advance : Robot -> Robot
advance robot =
    case robot.bearing of
        North ->
            let
                previousCoordinates =
                    robot.coordinates
                myY =
                    robot.coordinates.y
            in
            { robot | coordinates = { previousCoordinates | y = myY + 1 } }
        East ->
            let
                previousCoordinates =
                    robot.coordinates
                myX =
                    robot.coordinates.x
            in
            { robot | coordinates = { previousCoordinates | x = myX + 1 } }
        South ->
            let
                previousCoordinates =
                    robot.coordinates
                myY =
                    robot.coordinates.y
            in
            { robot | coordinates = { previousCoordinates | y = myY - 1 } }
        West ->
            let
                previousCoordinates =
                    robot.coordinates
                myX =
                    robot.coordinates.x
            in
            { robot | coordinates = { previousCoordinates | x = myX - 1 } }
execute : Char -> Robot -> Robot
execute directionChar thisRobot =
    case directionChar of
        'A' ->
            advance thisRobot
        'L' ->
            turnLeft thisRobot
        'R' ->
            turnRight thisRobot
        _ ->
            thisRobot
simulate : String -> Robot -> Robot
simulate directions robot =
    let
        charList =
            String.toList directions |> List.reverse
    in
    case charList of
        [] ->
            robot
        first :: rest ->
            execute first (simulate (List.foldl (++) "" (List.map (\x -> String.fromChar x) rest)) robot)

-- Dipaliso
-- https://exercism.org/tracks/elm/exercises/robot-simulator/solutions/dipaliso

-- Dipaliso doesn't access the nested coordinates record but update the coordinates record and create an new robot without updating the old one, which is a much easier solution
-- his or her 'process' function corresponds to my 'execute' function but then in 'simulate' the use of foldl semplificate things a lot compared to my recursive solution

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
    --{ bearing = North
    --, coordinates = { x = 0, y = 0 }
    --}
    Robot North { x = 0, y = 0 }
turnRight : Robot -> Robot
turnRight robot =
    case robot.bearing of
        North ->
            { robot | bearing = East }
        East ->
            { robot | bearing = South }
        South ->
            { robot | bearing = West }
        West ->
            { robot | bearing = North }
turnLeft : Robot -> Robot
turnLeft robot =
    case robot.bearing of
        North ->
            { robot | bearing = West }
        East ->
            { robot | bearing = North }
        South ->
            { robot | bearing = East }
        West ->
            { robot | bearing = South }
advance : Robot -> Robot
advance { bearing, coordinates } =
    case bearing of
        North ->
            Robot bearing { coordinates | y = coordinates.y + 1 }
        East ->
            Robot bearing { coordinates | x = coordinates.x + 1 }
        South ->
            Robot bearing { coordinates | y = coordinates.y - 1 }
        West ->
            Robot bearing { coordinates | x = coordinates.x - 1 }

simulate : String -> Robot -> Robot
simulate directions robot =
    List.foldl
        process
        robot
        (String.toList directions)

process : Char -> Robot -> Robot
process char robot =
    case char of
        'R' ->
            turnRight robot
        'L' ->
            turnLeft robot
        'A' ->
            advance robot
        _ ->
            robot

-- Jiegilet
-- https://exercism.org/tracks/elm/exercises/robot-simulator/solutions/jiegillet

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
  { robot |
    bearing = 
      case robot.bearing of
        North -> East
        East -> South
        South -> West
        West -> North
  }
turnLeft : Robot -> Robot
turnLeft robot =
  { robot |
    bearing = 
      case robot.bearing of
        North -> West
        East -> North
        South -> East
        West -> South
  }

advance : Robot -> Robot
advance robot =
  case (robot.bearing, robot.coordinates) of
    (North, { y, x }) -> { robot | coordinates = { y = y + 1, x = x }}
    (South, { y, x }) -> { robot | coordinates = { y = y - 1, x = x }}
    (East, { y, x }) -> { robot | coordinates = { y = y, x = x + 1 }}
    (West, { y, x }) -> { robot | coordinates = { y = y, x = x - 1 }}

simulate : String -> Robot -> Robot
simulate directions robot =
  let
    move direction =
      case direction of
        'L' -> turnLeft
        'R' -> turnRight
        'A' -> advance
        _ -> identity
  in 
  String.foldl move robot directions

-- User163
-- https://exercism.org/tracks/elm/exercises/robot-simulator/solutions/User163
-- similar approach like mine, without destructuring robot befor but elegantly solved. 

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
    case robot.bearing of
        North -> {robot | bearing = East}
        East ->  {robot | bearing = South}
        South -> {robot | bearing = West}
        West ->  {robot | bearing = North}
turnLeft : Robot -> Robot
turnLeft robot =
    case robot.bearing of
        North -> {robot | bearing = West}
        East ->  {robot | bearing = North}
        South -> {robot | bearing = East}
        West ->  {robot | bearing = South}
advance : Robot -> Robot
advance robot =
    let 
        vector = robot.coordinates
    in 
        case robot.bearing of
            North -> 
                {robot | coordinates = { x = vector.x, y = vector.y + 1}}
            East ->  
                {robot | coordinates = { x = vector.x + 1, y = vector.y}}
            South -> 
                {robot | coordinates = { x = vector.x, y = vector.y - 1}}
            West ->  
                {robot | coordinates = {x = vector.x - 1, y = vector.y}}
simulate : String -> Robot -> Robot
simulate directions robot =
    let
        l = String.split "" directions
    in
        case l of
            [] -> robot
            (x::xs) -> 
                case x of
                    "R" -> simulate (String.concat xs) (turnRight robot)
                    "L" -> simulate (String.concat xs) (turnLeft robot)
                    "A" -> simulate (String.concat xs) (advance robot)
                    _ -> robot
