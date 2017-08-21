module Components.SonComponent exposing (..)

import DomainModels.Son as Son exposing (Feeling(..), Son)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Keyboard
import Task


type Msg
    = ChangeActiveSon Son.Id
    | KeyDown Keyboard.KeyCode


type alias Model =
    { son : Son
    , isActive : Bool
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyDown code ->
            let
                nextSon =
                    if model.isActive then
                        case code of
                            38 ->
                                Son.backFeeling model.son

                            40 ->
                                Son.forwardFeeling model.son

                            _ ->
                                model.son
                    else
                        model.son
            in
            { model | son = nextSon } ! []

        ChangeActiveSon id ->
            { model | isActive = model.son.id == id } ! []


subscriptions : Sub Msg
subscriptions =
    Keyboard.downs KeyDown


sSonContainer : List ( String, String )
sSonContainer =
    [ ( "margin-left", "20px" )
    , ( "margin-top", "20px" )
    , ( "float", "left" )
    ]


sSonImg : List ( String, String )
sSonImg =
    [ ( "width", "120px" )
    , ( "height", "100px" )
    ]


sSonName : List ( String, String )
sSonName =
    [ ( "margin-left", "30px" )
    ]


sSonNameColor : List ( String, String )
sSonNameColor =
    [ ( "color", "red" ) ]


view : Model -> Html Msg
view model =
    let
        sonImgSrc =
            case model.son.feeling of
                Happy ->
                    "../../img/son-happy.png"

                Angry ->
                    "../../img/son-angry.png"

                Crying ->
                    "../../img/son-crying.png"

        sSonNameColorStyle =
            if model.isActive then
                sSonNameColor
            else
                []
    in
    div
        [ style sSonContainer
        , onClick <| ChangeActiveSon model.son.id
        ]
        [ img
            [ style sSonImg, src sonImgSrc ]
            []
        , div
            [ style <| sSonName ++ sSonNameColorStyle ]
            [ text model.son.name ]
        ]
