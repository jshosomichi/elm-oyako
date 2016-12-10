module Msg exposing (..)

import SonTypes exposing (..)


type Msg
    = ChangeFeeling SonTypes.Id SonTypes.FeelingDirection
    | ChangeActiveSonId SonTypes.Id
