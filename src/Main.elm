module Main exposing (..)

import Keyboard
import Dict exposing (Dict, insert)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Papa
import Son
import Styles


type Msg
    = ChangeFeeling Son.Id Son.FeelingDirection
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


keyCodeToMsg : Son.Id -> Keyboard.KeyCode -> Msg
keyCodeToMsg activeSonId code =
    case code of
        38 ->
            ChangeFeeling activeSonId Son.Backward

        40 ->
            ChangeFeeling activeSonId Son.Forward

        _ ->
            ChangeFeeling activeSonId Son.None


view : Model -> Html Msg
view { activeSonId, papaModel } =
    div [] [ papaView activeSonId papaModel ]


papaView : Son.Id -> Papa.Model -> Html Msg
papaView activeSonId { sonDict } =
    let
        sonViews =
            sonDict
                |> Dict.toList
                |> List.map (\( id, son ) -> son)
                |> List.map (\son -> sonView activeSonId son)

        papaImgSrc =
            if Papa.isGood sonDict then
                "../img/papa-good.png"
            else
                "../img/papa-bad.png"
    in
        div []
            [ img [ style Styles.papaImg, src papaImgSrc ] []
            , div [] sonViews
            ]


sonView : Son.Id -> Son.Model -> Html Msg
sonView activeSonId model =
    let
        sonImgSrc =
            case model.feeling of
                Son.Happy ->
                    "../img/son-happy.png"

                Son.Angry ->
                    "../img/son-angry.png"

                Son.Crying ->
                    "../img/son-crying.png"

        sonNameColorStyle =
            if activeSonId == model.id then
                Styles.sonNameColor
            else
                []
    in
        div [ style Styles.sonContainer, onClick <| ChangeActiveSonId model.id ]
            [ img [ style Styles.sonImg, src sonImgSrc ] []
            , div [ style <| Styles.sonName ++ sonNameColorStyle ] [ text model.name ]
            ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
