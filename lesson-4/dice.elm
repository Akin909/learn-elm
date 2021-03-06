module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Animation exposing (..)
import Time exposing (second)
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
    ( Model 1 1, Cmd.none )


type alias Model =
    { dieFace1 : Int, dieFace2 : Int }



--circle : List (Attribute msg) -> List (Svg msg)


fullCircle =
    svg
        [ viewBox "0 0 100 100", Svg.Attributes.width "20px" ]
        [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
        ]


myAnim =
    animation 0 |> from 100 |> to 300 |> duration (4 * second) |> delay (1 * second) List.map (\t -> animate (t * second) myAnim [0..6])


view : Model -> Html Msg
view model =
    div
        [ Html.Attributes.style
            [ ( "text-align", "center" )
            , ( "display", "flex" )
            , ( "align-items", "center" )
            , ( "flex-direction", "column" )
            , ( "justify-content", "center" )
            , ( "margin", "0.4em" )
            , ( "width", "100%" )
            , ( "height", "100%" )
            ]
        ]
        [ div [ Html.Attributes.style [ ( "display", "flex" ) ] ]
            [ div [ Html.Attributes.style dieStyle ] [ Html.text (toString model.dieFace1), fullCircle ]
            , div [ Html.Attributes.style dieStyle ] [ Html.text (toString model.dieFace2), fullCircle ]
            ]
        , button [ onClick Roll, Html.Attributes.style buttonStyle ] [ Html.text "Roll" ]
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
    , ( "margin", "1rem" )
    , ( "font-size", "1.3em" )
    , ( "display", "flex" )
    , ( "align-items", "center" )
    , ( "justify-content", "center" )
    , ( "font-family", "Helvetica" )
    , ( "animation", myAnim )
    ]


type Msg
    = Roll
    | NewFace1 Int
    | NewFace2 Int


ran msg =
    Random.generate msg (Random.int 1 6)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Cmd.batch [ ran NewFace1, ran NewFace2 ] )

        NewFace1 newFace ->
            ( { model | dieFace1 = newFace }, Cmd.none )

        NewFace2 newFace ->
            ( { model | dieFace2 = newFace }, Cmd.none )



--subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
