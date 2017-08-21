module Components.PapaComponent exposing (..)

import Components.SonComponent as SonComponent
import DomainModels.Papa exposing (Papa)
import DomainModels.Son as Son exposing (Son)
import Html exposing (..)
import Html.Attributes exposing (..)


type Msg
    = SonMsg SonComponent.Msg


type alias Model =
    { papa : Papa
    , sonModels : List SonComponent.Model
    }


isGood : List SonComponent.Model -> Bool
isGood =
    List.all (\sonModel -> Son.isHappy <| sonModel.son)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SonMsg sonMsg ->
            let
                updated =
                    List.map (SonComponent.update sonMsg) model.sonModels

                nextSonModels =
                    List.map Tuple.first updated
            in
            { model | sonModels = nextSonModels } ! []


subscriptions : Sub Msg
subscriptions =
    Sub.map SonMsg SonComponent.subscriptions


sPapaName : List ( String, String )
sPapaName =
    [ ( "margin-left", "110px" )
    ]


sPapaImg : List ( String, String )
sPapaImg =
    [ ( "margin-top", "30px" )
    , ( "margin-left", "50px" )
    , ( "width", "180px" )
    , ( "height", "150px" )
    ]


view : Model -> Html Msg
view { papa, sonModels } =
    let
        sonViews =
            sonModels
                |> List.map (\sonModel -> Html.map SonMsg (SonComponent.view sonModel))

        papaImgSrc =
            if isGood sonModels then
                "../../img/papa-good.png"
            else
                "../../img/papa-bad.png"
    in
    div []
        [ img
            [ style sPapaImg
            , src papaImgSrc
            ]
            []
        , div [ style sPapaName ] [ text papa.name ]
        , div [] sonViews
        ]
