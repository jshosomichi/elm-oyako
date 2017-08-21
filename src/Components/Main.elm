module Main exposing (..)

import Components.PapaComponent as PapaComponent
import DataSource.InitialData exposing (initialData)
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)


type Msg
    = PapaMsg PapaComponent.Msg


type alias Model =
    { papaModel : PapaComponent.Model
    }


init : ( Model, Cmd Msg )
init =
    initialData ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PapaMsg papaMsg ->
            let
                ( newPapaModel, _ ) =
                    PapaComponent.update papaMsg model.papaModel
            in
            { model | papaModel = newPapaModel } ! []


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.map PapaMsg <| PapaComponent.subscriptions


view : Model -> Html Msg
view { papaModel } =
    div [] [ Html.map PapaMsg <| PapaComponent.view papaModel ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
