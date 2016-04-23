module Player.Models (PlayerModel, PlayerId, newPlayer) where


type alias PlayerModel =
  { name : String
  , id : PlayerId
  }


type alias PlayerId =
  Int


newPlayer : PlayerId -> String -> PlayerModel
newPlayer id name =
  { name = name
  , id = id
  }
