module Son exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Keyboard
import Task


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


initModel : Id -> Name -> Feeling -> Model
initModel =
    Model


dummySon : Model
dummySon =
    initModel 0 "" Happy


backFeeling : Feeling -> Feeling
backFeeling feeling =
    case feeling of
        Happy ->
            Crying

        Angry ->
            Happy

        Crying ->
            Angry


forwardFeeling : Feeling -> Feeling
forwardFeeling feeling =
    case feeling of
        Happy ->
            Angry

        Angry ->
            Crying

        Crying ->
            Happy


updateFeeling : FeelingDirection -> Model -> Model
updateFeeling code model =
    case code of
        Forward ->
            { model | feeling = forwardFeeling model.feeling }

        Backward ->
            { model | feeling = backFeeling model.feeling }

        None ->
            model
