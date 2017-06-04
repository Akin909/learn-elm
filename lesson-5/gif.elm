module Main exposing (..)

import Http exposing (..)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Json.Decode as Decode
import String exposing (..)
import Char exposing (..)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { topic : String
    , gifUrl : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "dogs" "stuff.gif", Cmd.none )



--UPDATE


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic

        request =
            Http.get url decodeGifUrl
    in
        Http.send NewGif request


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string


type Msg
    = MorePlease
    | NewGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( model, getRandomGif model.topic )

        NewGif (Ok newUrl) ->
            ( { model | gifUrl = newUrl }, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )



-- VIEW


divStyle =
    [ ( "display", "flex" )
    , ( "flex-direction", "column" )
    , ( "justify-content", "space-around" )
    , ( "align-items", "center" )
    , ( "background-color", "palevioletred" )
    , ( "height", "100%" )
    , ( "width", "100%" )
    ]


title =
    [ ( "text-align", "center" )
    , ( "font-family", "Helvetica" )
    , ( "font-size", "2em" )
    , ( "color", "white" )
    , ( "text-shadow", "0 1px 1px rgba(0, 0, 0, 0.5)" )
    ]


buttonStyle =
    [ ( "width", "4rem" )
    , ( "margin-bottom", "4em" )
    , ( "border", "none" )
    , ( "box-shadow", "0 1px 0 rgba(0, 0, 0, 0.5)" )
    ]


inputStyle =
    [ ( "width", "10em" )
    , ( "height", "1.3em" )
    , ( "border", "none" )
    , ( "padding", "0.5em" )
    ]


gifStyle =
    [ ( " width", "50%" ) ]


capitalise : String -> String
capitalise word =
    case uncons word of
        Nothing ->
            ""

        Just ( head, tail ) ->
            append (fromChar (Char.toUpper head)) tail


view : Model -> Html Msg
view model =
    div [ style divStyle ]
        [ input [ style inputStyle, placeholder "Type in a subject" ] []
        , h2 [ style title ] [ text (capitalise model.topic) ]
        , img [ src model.gifUrl, style gifStyle ] []
        , button [ style buttonStyle, onClick MorePlease ] [ text "More Please!" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
