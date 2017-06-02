module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random exposing (generate)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( Model 1, Cmd.none )


type alias Model =
    { dieFace : Int }


view : Model -> Html Msg
view model =
    div
        [ style
            [ ( "text-align", "center" )
            , ( "display", "flex" )
            , ( "flex-direction", "column" )
            , ( "align-items", "center" )
            , ( "justify-content", "center" )
            , ( "width", "100%" )
            , ( "height", "100%" )
            ]
        ]
        [ div [ style dieStyle ] [ text (toString model.dieFace) ]
        , button [ onClick Roll, style buttonStyle ] [ text "Roll" ]
        ]


buttonStyle : List ( String, String )
buttonStyle =
    [ ( "background-color", "palevioletred" )
    , ( "border", "none" )
    , ( "border-radius", "5px" )
    , ( "box-shadow", "0 1px 0 grey" )
    , ( "width", "5rem" )
    , ( "height", "2rem" )
    ]


dieStyle : List ( String, String )
dieStyle =
    [ ( "background-color", "whitesmoke" )
    , ( "border", "solid 0.5px grey" )
    , ( "border-radius", "15px" )
    , ( "box-shadow", "0 1px 0 grey" )
    , ( "width", "10rem" )
    , ( "height", "10rem" )
    , ( "margin-bottom", "2rem" )
    ]


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFace (Random.int 1 6) )

        NewFace newFace ->
            ( Model newFace, Cmd.none )



--subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
