module Main exposing (..)

import Keyboard
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msg exposing (Msg(..))
import Papa
import Son
import SonTypes exposing (..)


type alias Model =
    { activeSonId : SonTypes.Id
    , papaModel : Papa.Model
    }


init : ( Model, Cmd Msg )
init =
    { activeSonId = 1, papaModel = Papa.initModel } ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeFeeling id direction ->
            let
                papa =
                    Papa.updateSonsFeeling model.activeSonId direction model.papaModel
            in
                { model | papaModel = papa } ! []

        ChangeActiveSonId id ->
            { model | activeSonId = id } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Keyboard.downs (keyCodeToMsg model.activeSonId)


keyCodeToMsg : SonTypes.Id -> Keyboard.KeyCode -> Msg
keyCodeToMsg activeSonId code =
    case code of
        38 ->
            ChangeFeeling activeSonId SonTypes.Backward

        40 ->
            ChangeFeeling activeSonId SonTypes.Forward

        _ ->
            ChangeFeeling activeSonId SonTypes.None


view : Model -> Html Msg
view { activeSonId, papaModel } =
    div [] [ Papa.view activeSonId papaModel ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
