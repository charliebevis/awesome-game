module Awesome.View
  ( view
  , viewPicture
  ) where

import Awesome.Model exposing (Block, Picture)
import Awesome.Color as C exposing (..)

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Text

import List exposing (..)
import Matrix


view : List Picture -> Element
view pictures =
  pictures
  |> map viewPicture
  |> intersperse spacer
  |> flow down

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
boxSize = 80


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
