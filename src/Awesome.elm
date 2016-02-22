module Awesome where

import Signal exposing (..)
import Random
import Awesome.Random
import Awesome.Model exposing (..)
import Awesome.View exposing (..)
import Time
import Mouse

main =
  Signal.map view gameState


gameState : Signal.Signal (List Picture)
gameState =
  Signal.map samplePictures countClick

countClick : Signal Int
countClick = Signal.foldp (\click count -> count + 1) 0 Mouse.clicks

samplePictures : Int -> List Picture
samplePictures i =
  let
    seed = Random.initialSeed i
    (p, seed') = Random.generate (Random.list 10 Awesome.Random.picture) seed
  in
    p
