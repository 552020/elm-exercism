# Pattern Matching

[Elm Destructuring (or Pattern Matching) Cheatsheet](https://gist.github.com/yang-wei/4f563fbf81ff843e8b1e) by Yang Wei

## Exercise

`Ticket` is a Custom Type.

- List.filter
- List.length
  https://package.elm-lang.org/packages/elm/core/latest/List

### Errors I got from the compiler

#### 1. Type Mismatch

##### The Problem

My code:

```elm

numberOfCreatorComments : Ticket -> Int
numberOfCreatorComments { status, createdBy, assignedTo, comments } =
    let
        (user, number) = createdBy
    in
    List.length (List.filter (\ (userInComments, comment) -> userInComments == user ) comments)
    -- Debug.todo "Please implement the function numberOfCreatorComments"

```

The error:

```bash
-- TYPE MISMATCH --------------------- /opt/test-runner/app/src/TicketPlease.elm

The 1st argument to `numberOfCreatorComments` is weird.

16| numberOfCreatorComments { status, createdBy, assignedTo, comments} =
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The argument is a pattern that matches record values of type:

    { e | assignedTo : a, comments : b, createdBy : c, status : d }

But the type annotation on `numberOfCreatorComments` says the 1st argument
should be:

    Ticket
```

The analysis:

Elm didn't like this line `numberOfCreatorComments { status, createdBy, assignedTo, comments } =`.
Why I wrote it? My idea was to destructure the Record `Ticket`.

How did I solve this?

I played aroung a little bit in the REPL with the three Custom Types of the programm: `Ticket`, `Status`, `User`. Entering the definition of `Ticket` we get an error cause `Ticket` uses also `Status` and `User`. After I defined `User` and `Status` I could declare also `Ticket`

```elm
type User
    = User String

type Status
    = New
    | InProgress
    | Resolved
    | Closed
    | Archived

type Ticket
    = Ticket
        { status : Status
        , createdBy : ( User, Int )
        , assignedTo : Maybe User
        , comments : List ( User, String )
        }
```

Noteworthy here is that the type `Status` as 5 possible value or variants, but `Status` is not itself a variant. After the declaration of the Custom Type `Status` if just type `Status` in the REPL we get an error. The same way if we enter `Bool` in the REPL. If we type `True` we get `True : Bool` as an answer, but entering `Bool` we get a `NAMING ERROR`

`Ticket` and `User` are also the only variant of the Custom Type.

Then I read the Cheatsheet listed above, the way

`numberOfCreatorComments (Ticket { status, createdBy, assignedTo, comments }) =`

In the comments of the Cheatsheet I found the way to destructure a Custom Type (Union Type) with only one member.

```elm
type MyThing
  = AString String


unionFn : MyThing -> String
unionFn  (AString a) = a
```

```elm

type AThing = AThing { foo: String, bar: Int }

foo (AThing { foo }) = foo
```
