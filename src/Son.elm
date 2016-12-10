module Son exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msg exposing (Msg(..))
import SonTypes exposing (..)


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


sonContainer : List ( String, String )
sonContainer =
    [ ( "margin-left", "20px" )
    , ( "margin-top", "20px" )
    , ( "float", "left" )
    ]


sonImg : List ( String, String )
sonImg =
    [ ( "width", "120px" )
    , ( "height", "100px" )
    ]


sonName : List ( String, String )
sonName =
    [ ( "margin-left", "30px" )
    ]


sonNameColor : List ( String, String )
sonNameColor =
    [ ( "color", "red" ) ]


view : Id -> Model -> Html Msg
view activeSonId model =
    let
        sonImgSrc =
            case model.feeling of
                Happy ->
                    "../img/son-happy.png"

                Angry ->
                    "../img/son-angry.png"

                Crying ->
                    "../img/son-crying.png"

        sonNameColorStyle =
            if activeSonId == model.id then
                sonNameColor
            else
                []
    in
        div [ style sonContainer, onClick <| ChangeActiveSonId model.id ]
            [ img [ style sonImg, src sonImgSrc ] []
            , div [ style <| sonName ++ sonNameColorStyle ] [ text model.name ]
            ]
