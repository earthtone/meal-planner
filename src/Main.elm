module Main exposing (main)

import Browser
import Html exposing (button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import TW


main =
    Browser.sandbox { init = 0, update = update, view = view }


type Msg
    = Increment
    | Decrement


update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1


view model =
    div [ TW.flex, TW.w_full, TW.justify_center, TW.pt_3 ]
        [ button [ onClick Decrement, TW.py_1, TW.px_2, TW.mx_2 ] [ text "-" ]
        , div [ TW.text_4xl ] [ text (String.fromInt model) ]
        , button [ onClick Increment, TW.py_1, TW.px_2, TW.mx_2 ] [ text "+" ]
        ]
