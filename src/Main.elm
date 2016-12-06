module Main exposing (..)

import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Papa
import Son


type Msg
    = PapaMsgWrap Papa.Msg


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
                case papaMsg of
                    Papa.SonMsgWrap (Son.ChangeActiveSon id) ->
                        { model | activeSonId = id } ! []

                    _ ->
                        { model | papaModel = newPapaModel } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map PapaMsgWrap <| Papa.subscriptions model.papaModel


view : Model -> Html Msg
view model =
    div [] [ Html.map PapaMsgWrap <| Papa.view model.activeSonId model.papaModel ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
