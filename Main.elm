module Main (..) where

import Signal
import Html exposing (Html)
import StartApp.Simple as StartApp
import Html.Attributes as Attributes
import Html.Events exposing (onClick, on, targetValue)


type alias Model =
  { players : List Player
  , field : String
  }


type alias Player =
  { name : String
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
          , players = model.players ++ [ newPlayer model.field ]
        }
      else
        model

    FieldChange value ->
      { model
        | field = value
      }


newPlayer : String -> Player
newPlayer name =
  { name = name
  }


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
        (List.map
          (\player ->
            Html.li [] [ Html.text player.name ]
          )
          model.players
        )
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
