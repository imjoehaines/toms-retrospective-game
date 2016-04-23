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
  }


type Action
  = Reset
  | AddNewPlayer
  | FieldChange String


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


newId : List PlayerModel -> PlayerId
newId players =
  (Maybe.withDefault 0 (List.maximum (List.map (\player -> player.id) players))) + 1


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
        [ onClick address AddNewPlayer
        ]
        [ Html.text "add user" ]
    , Html.button
        [ onClick address Reset
        ]
        [ Html.text "reset" ]
    , Html.ul
        []
        (List.map playerView model.players)
    ]


initialModel : Model
initialModel =
  { players = []
  , field = ""
  }


main : Signal Html
main =
  StartApp.start
    { model = initialModel
    , view = view
    , update = update
    }
