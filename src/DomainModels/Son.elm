module DomainModels.Son exposing (..)


type alias Id =
    Int


type alias Name =
    String


type Feeling
    = Happy
    | Angry
    | Crying


type alias Son =
    { id : Id
    , name : Name
    , feeling : Feeling
    }


isHappy : Son -> Bool
isHappy son =
    son.feeling == Happy


backFeeling : Son -> Son
backFeeling son =
    case son.feeling of
        Happy ->
            { son | feeling = Crying }

        Angry ->
            { son | feeling = Happy }

        Crying ->
            { son | feeling = Angry }


forwardFeeling : Son -> Son
forwardFeeling son =
    case son.feeling of
        Happy ->
            { son | feeling = Angry }

        Angry ->
            { son | feeling = Crying }

        Crying ->
            { son | feeling = Happy }
