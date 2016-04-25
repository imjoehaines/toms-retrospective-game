module Card.Models (CardModel, CardId, randomCard) where


type alias CardModel =
  { text : String
  , id : CardId
  }


type alias CardId =
  Int


cards : List CardModel
cards =
  [ { text = "hello", id = 1 }
  , { text = "hi", id = 2 }
  , { text = "hey", id = 3 }
  , { text = "howdy", id = 4 }
  ]


randomCard : CardModel
randomCard =
  List.head cards
    |> Maybe.withDefault { text = "no", id = 0 }
