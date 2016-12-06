module Main exposing (..)

import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Papa
import Son


type Msg
    = PapaMsgWrap Papa.Msg
    | SonMsgWrap Son.Msg


type alias Model =
    { activeSonId : Son.Id
    , papaModel : Papa.Model
    }


init : ( Model, Cmd Msg )
init =
    { activeSonId = 1, papaModel = Papa.initModel } ! []


targetSon : Son.Id -> Dict Son.Id Son.Model -> Son.Model
targetSon id sonDict =
    sonDict
        |> Dict.get id
        |> Maybe.withDefault Son.dummySon


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PapaMsgWrap papaMsg ->
            let
                ( papaModel, _ ) =
                    Papa.update papaMsg model.papaModel
            in
                case papaMsg of
                    Papa.SonMsgWrap sonMsg ->
                        case sonMsg of
                            Son.ChangeActiveSon id ->
                                { model | activeSonId = id } ! []

                            _ ->
                                model ! []

        SonMsgWrap sonMsg ->
            let
                ( sonModel, _ ) =
                    Son.update sonMsg (targetSon model.activeSonId model.papaModel.sonDict)

                papaModel =
                    model.papaModel

                newSonDict =
                    Dict.insert model.activeSonId sonModel model.papaModel.sonDict
            in
                { model | papaModel = { papaModel | sonDict = newSonDict } } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map SonMsgWrap Son.subscriptions


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
