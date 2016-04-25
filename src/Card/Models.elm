module Card.Models (randomCard) where


cards : List String
cards =
  [ "hello"
  , "hi"
  , "hey"
  , "howdy"
  ]


randomCard : String
randomCard =
  List.head cards
    |> Maybe.withDefault ""
