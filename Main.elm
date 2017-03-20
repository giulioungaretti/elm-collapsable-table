module Main exposing (..)

import Html exposing (program, Html, text, div, img, h1, td, table, thead, th, tbody, tr, button)
import Html.Attributes exposing (class, hidden, rowspan, colspan)


type alias Parameter =
    { name : String
    , value : String
    }


type alias Container =
    { instrument : String
    , parameters : List Parameter
    }


type alias Model =
    { parameters : List Container
    }


viewParameter parameter =
    [ td [] [ text parameter.name ]
    ]


viewfields : Bool -> Parameter -> List (Html msg)
viewfields isHidden parameter =
    [ td []
        [ div [ hidden isHidden ]
            [ text parameter.name
            ]
        ]
    , td []
        [ div [ hidden isHidden ]
            [ text parameter.value
            ]
        ]
    ]


viewEmpty : List (Html msg)
viewEmpty =
    [ td [] [ text "" ]
    , td [] [ text "" ]
    ]


viewParamDetails : Bool -> Parameter -> Html msg
viewParamDetails isHidden parameter =
    tr [] (viewfields isHidden parameter)



--viewHead : List Parameter -> List (Html msg)
--viewHead parameterList =
--case List.head parameterList of
--Nothing ->
--[ td [] [ text "" ] ]
--Just param ->
--viewfields param
--viewTail : List Parameter -> List (Html msg)
--viewTail parameterList =
--case List.tail parameterList of
--Nothing ->
--[ tr [] [ td [] [ text "" ] ] ]
--Just param ->
--List.map viewParamDetails param


isHidden instrument =
    if instrument == "qdac" then
        True
    else
        False


viewNames : Container -> List (Html msg)
viewNames container =
    tr [ class "yolo" ]
        (td [ rowspan ((List.length container.parameters) + 1) ] [ text container.instrument ]
            :: viewEmpty
        )
        :: List.map (viewParamDetails (isHidden container.instrument)) container.parameters


viewtable : Model -> Html msg
viewtable model =
    table []
        [ thead []
            [ tr []
                [ th [] [ text "instrument" ]
                , th [] [ text "Name" ]
                ]
            ]
        , tbody [] (List.concatMap viewNames model.parameters)
        ]


main =
    viewtable
        (Model
            [ (Container "qdac1" [ (Parameter "yolo" "ya"), (Parameter "much" "foo"), (Parameter "whow" "bar") ])
            , (Container "qdac" [ (Parameter "yolo" "ya"), (Parameter "much" "foo"), (Parameter "whow" "bar") ])
            , (Container "" [ (Parameter "yolo" "ya"), (Parameter "much" "foo"), (Parameter "whow" "bar") ])
            ]
        )
