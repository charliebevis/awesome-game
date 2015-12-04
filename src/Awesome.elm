module Awesome where

import Signal exposing (..)
import Random
import Awesome.Random
import Awesome.Model exposing (..)
import Awesome.View exposing (..)

main =
  Signal.map view gameState

gameState =
  constant samplePictures
  
samplePictures : List Picture
samplePictures = 
  let
    (p, seed) = Random.generate (Random.list 10 Awesome.Random.picture) (Random.initialSeed 1337)
  in
    p