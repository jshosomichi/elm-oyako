module DataSource.InitialData exposing (..)

import Components.SonComponent as SonComponent
import DomainModels.Papa exposing (Papa)
import DomainModels.Son exposing (Feeling(..), Son)


initialData =
    { papaModel =
        { papa = Papa "としひこ"
        , sonModels =
            [ SonComponent.Model (Son 1 "いちろう" Angry) True
            , SonComponent.Model (Son 2 "じろう" Crying) False
            ]
        }
    }
