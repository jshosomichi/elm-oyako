module Main exposing (..)

import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Papa
import Son


type Msg
    = PapaMsgWrap Papa.Msg
    | ChangeActiveSonId Son.Id


type alias Model =
    { activeSonId : Son.Id
    , papaModel : Papa.Model
    }


init : ( Model, Cmd Msg )
init =
    { activeSonId = 1, papaModel = Papa.initModel } ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PapaMsgWrap papaMsg ->
            let
                ( newPapaModel, _ ) =
                    Papa.update model.activeSonId papaMsg model.papaModel
            in
                { model | papaModel = newPapaModel } ! []

        ChangeActiveSonId id ->
            { model | activeSonId = id } ! []


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.map PapaMsgWrap <| Papa.subscriptions


view : Model -> Html Msg
view { activeSonId, papaModel } =
    div [] [ Papa.view ChangeActiveSonId activeSonId papaModel ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
