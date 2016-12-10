module Papa exposing (..)

import Dict exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Son


type alias Model =
    { sonDict : Dict Son.Id Son.Model }


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


isGood : Dict Son.Id Son.Model -> Bool
isGood =
    Dict.toList
        >> List.map (\( id, son ) -> son)
        >> List.all (\son -> son.feeling == Son.Happy)


updateSonsFeeling : Son.Id -> Son.FeelingDirection -> Model -> Model
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
