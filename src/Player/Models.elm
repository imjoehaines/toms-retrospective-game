module Player.Models (PlayerModel, PlayerId, newPlayer) where


type alias PlayerModel =
  { name : String
  , id : PlayerId
  }


type alias PlayerId =
  Int


newPlayer : List PlayerModel -> String -> PlayerModel
newPlayer players name =
  { name = name
  , id = newId players
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
