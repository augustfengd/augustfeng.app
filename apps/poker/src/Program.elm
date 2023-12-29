module Program exposing (main)

import Html exposing (div, text)
import Browser
import Html.Attributes

-- model

type alias Model = {}

type alias Week =
    { monday : Int
    , tuesday : Int
    , wednesday : Int
    , thursday:  Int
    , friday : Int
    , saturday : Int
    , sunday : Int
    }

-- view

viewWeekHeader =
    div [ Html.Attributes.class "grid", Html.Attributes.class "grid-cols-7" ]
        (List.map (\c -> div [] [ text c ]) ["M", "T", "W", "T", "F", "S", "S"])

viewWeek =
    div [ Html.Attributes.class "grid", Html.Attributes.class "grid-cols-7" ]
        (List.map (\c -> div [] [ text c ]) ["1", "2", "3", "4", "5", "6", "7"])


view model =
    div []
        [ viewWeekHeader
        , viewWeek
        ]

-- update

init flags =
    ( {}
    , Cmd.none
    )

update msg model =
    ( {}
    , Cmd.none
    )

subscriptions model =
    Sub.none

main : Program () Model ()
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
