module SonTypes exposing (..)


type FeelingDirection
    = Forward
    | Backward
    | None


type alias Id =
    Int


type alias Name =
    String


type Feeling
    = Happy
    | Angry
    | Crying


type alias Model =
    { id : Id
    , name : Name
    , feeling : Feeling
    }
