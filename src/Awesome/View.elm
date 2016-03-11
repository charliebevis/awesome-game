module Awesome.View
  ( viewGame
  ) where

import Awesome.Model exposing (Block, Picture, GameState)
import Awesome.Color as C exposing (..)

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Text

import List exposing (..)
import Matrix



viewGame : GameState -> Element
viewGame ({chosenPictures, availablePictures} as game) =
  let
    available = viewAvailable availablePictures
    chosen = viewChosen chosenPictures
  in
    [ available
    , spacer
    , chosen
    ]
      |> flow down

viewAvailable : List Picture -> Element
viewAvailable pictures =
  pictures
  |> map viewPicture
  |> indexedMap prependNumber
  |> intersperse spacer
  |> flow right


viewChosen : List Picture -> Element
viewChosen pictures =
  pictures
  |> map viewPicture
  |> intersperse spacer
  |> flow left


prependNumber : Int -> Element -> Element
prependNumber number el =
  flow right [viewNumber number, el]


viewNumber : Int -> Element
viewNumber n =
  let
    text = Text.fromString <| toString n
    d = Text.defaultStyle
    style = { d |
        height = Just 40
      }

  in
    centered <| Text.style style text



viewPicture : Picture -> Element
viewPicture picture =
  Matrix.map (\block ->
    Maybe.map box block
    |> Maybe.withDefault empty
  ) picture
  |> Matrix.toList
  |> List.map (flow right)
  |> flow down


boxSize : Int
boxSize = 40


spacer : Element
spacer = empty


empty : Element
empty =
  let
    s = square (toFloat boxSize)
    innerColor = C.white
  in
    collage boxSize boxSize [filled innerColor s]


box : Block -> Element
box block =
  let
    s = square (toFloat boxSize)
    innerColor = C.color block
    borderColor = darken 0.2 innerColor
    inside = filled innerColor s
    border = outlined (solid borderColor) s
  in
    collage boxSize boxSize [inside, border]


txt str =
  Text.fromString str
  |> Text.monospace
  |> centered
