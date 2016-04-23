module Player.Views (playerView) where

import Html exposing (Html)
import Player.Models exposing (PlayerModel)


playerView : PlayerModel -> Html
playerView player =
  Html.li [] [ Html.text (player.name ++ " (" ++ toString player.id ++ ")") ]
