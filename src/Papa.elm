module Papa exposing (..)

import Dict exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Son


type Msg
    = SonMsgWrap Son.Msg


type alias Model =
    { sonDict : Dict Son.Id Son.Model }


isGood : Dict Son.Id Son.Model -> Bool
isGood =
    Dict.toList
        >> List.map (\( id, son ) -> son)
        >> List.all (\son -> son.feeling == Son.Happy)


initModel =
    let
        sons =
            [ Son.initModel 1 "いちろう" Son.Angry
            , Son.initModel 2 "じろう" Son.Crying
            ]

        sonDict =
            sons
                |> List.map (\son -> ( son.id, son ))
                |> Dict.fromList
    in
        { sonDict = sonDict }


targetSon : Son.Id -> Dict Son.Id Son.Model -> Son.Model
targetSon id =
    Dict.get id >> Maybe.withDefault Son.dummySon


update : Son.Id -> Msg -> Model -> ( Model, Cmd Msg )
update sonId msg model =
    case msg of
        SonMsgWrap sonMsg ->
            let
                ( sonModel, _ ) =
                    targetSon sonId model.sonDict
                        |> Son.update sonMsg

                newSonDict =
                    Dict.insert sonId sonModel model.sonDict
            in
                { model | sonDict = newSonDict } ! []


subscriptions : Sub Msg
subscriptions =
    Sub.map SonMsgWrap Son.subscriptions


papaImg : List ( String, String )
papaImg =
    [ ( "margin-top", "30px" )
    , ( "margin-left", "50px" )
    , ( "width", "180px" )
    , ( "height", "150px" )
    ]


view : (Son.Id -> highLevelMsg) -> Son.Id -> Model -> Html highLevelMsg
view highLevelMsg activeSonId { sonDict } =
    let
        sonViews =
            sonDict
                |> Dict.toList
                |> List.map (\( id, son ) -> son)
                |> List.map (\son -> Son.view highLevelMsg activeSonId son)

        papaImgSrc =
            if isGood sonDict then "../img/papa-good.png" else "../img/papa-bad.png"
    in
        div []
            [ img [ style papaImg , src papaImgSrc ] []
            , div [] sonViews
            ]
