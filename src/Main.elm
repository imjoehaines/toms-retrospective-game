module Main (..) where

import Signal
import Html exposing (Html)
import StartApp.Simple as StartApp
import Html.Attributes as Attributes
import Player.Views exposing (playerView)
import Html.Events exposing (onClick, on, targetValue)
import Player.Models exposing (PlayerModel, PlayerId, newPlayer)


type alias Model =
  { players : List PlayerModel
  , field : String
  , card : String
  }


type Action
  = Reset
  | AddNewPlayer
  | FieldChange String
  | DrawCard ( Card, String )


type Card
  = ScrumCard
  | TrapCard
  | TheOtherKindOfCardThatICantRememberRightNow


randomCard : ( Card, String )
randomCard =
  ( ScrumCard, "hi" )


update : Action -> Model -> Model
update action model =
  case action of
    Reset ->
      initialModel

    AddNewPlayer ->
      if model.field /= "" then
        { model
          | field = ""
          , players = model.players ++ [ newPlayer (newId model.players) model.field ]
        }
      else
        model

    FieldChange value ->
      { model
        | field = value
      }

    DrawCard ( card, cardText ) ->
      { model
        | card = cardText
      }


newId : List PlayerModel -> PlayerId
newId players =
  let
    playerIds =
      List.map (\player -> player.id) players
  in
    List.maximum playerIds
      |> Maybe.withDefault 0
      |> (+) 1


view : Signal.Address Action -> Model -> Html
view address model =
  Html.div
    []
    [ Html.input
        [ Attributes.value model.field
        , on "input" targetValue (Signal.message address << FieldChange)
        ]
        []
    , Html.button
        [ onClick address AddNewPlayer ]
        [ Html.text "add user" ]
    , Html.button
        [ onClick address (DrawCard randomCard) ]
        [ Html.text "draw card" ]
    , Html.button
        [ onClick address Reset ]
        [ Html.text "reset" ]
    , Html.ul
        []
        (List.map playerView model.players)
    , Html.h2
        []
        [ Html.text model.card ]
    ]


initialModel : Model
initialModel =
  { players = []
  , field = ""
  , card = ""
  }


main : Signal Html
main =
  StartApp.start
    { model = initialModel
    , view = view
    , update = update
    }
