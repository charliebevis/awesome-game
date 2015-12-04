module Awesome.Color where

import Awesome.Model exposing (..)
import Color exposing (Color, rgb, red, hsla, toHsl)

color : Block -> Color
color block =
  case block of
    White -> white
    Black -> grey
    Red -> red
    Blue -> blue
    Yellow -> yellow

white : Color
white = rgb 255 255 255

grey : Color
grey = rgb 45 45 45

blue : Color
blue = rgb 0 0 255

yellow : Color
yellow = rgb 255 255 0

red : Color
red = rgb 255 0 0

darken : Float -> Color -> Color
darken percent c =
  let
    pre = toHsl c
    post = { pre | lightness = (min pre.lightness (pre.lightness * (1 - percent)))}
  in
    hsla post.hue post.saturation post.lightness post.alpha
