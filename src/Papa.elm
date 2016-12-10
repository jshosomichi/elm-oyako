module Papa exposing (..)

import Dict exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (Msg(..))
import Son
import SonTypes


type alias Model =
    { sonDict : Dict SonTypes.Id SonTypes.Model }


initModel =
    let
        sons =
            [ Son.initModel 1 "いちろう" SonTypes.Angry
            , Son.initModel 2 "じろう" SonTypes.Crying
            ]

        sonDict =
            sons
                |> List.map (\son -> ( son.id, son ))
                |> Dict.fromList
    in
        { sonDict = sonDict }


isGood : Dict SonTypes.Id SonTypes.Model -> Bool
isGood =
    Dict.toList
        >> List.map (\( id, son ) -> son)
        >> List.all (\son -> son.feeling == SonTypes.Happy)


updateSonsFeeling : SonTypes.Id -> SonTypes.FeelingDirection -> Model -> Model
updateSonsFeeling id direction model =
    let
        newSon =
            Dict.get id model.sonDict
                |> Maybe.withDefault Son.dummySon
                |> Son.updateFeeling direction

        newSonDict =
            Dict.insert id newSon model.sonDict
    in
        { model | sonDict = newSonDict }


papaImg : List ( String, String )
papaImg =
    [ ( "margin-top", "30px" )
    , ( "margin-left", "50px" )
    , ( "width", "180px" )
    , ( "height", "150px" )
    ]


view : SonTypes.Id -> Model -> Html Msg
view activeSonId { sonDict } =
    let
        sonViews =
            sonDict
                |> Dict.toList
                |> List.map (\( id, son ) -> son)
                |> List.map (\son -> Son.view activeSonId son)

        papaImgSrc =
            if isGood sonDict then
                "../img/papa-good.png"
            else
                "../img/papa-bad.png"
    in
        div []
            [ img [ style papaImg, src papaImgSrc ] []
            , div [] sonViews
            ]
