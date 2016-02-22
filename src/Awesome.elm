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
  Signal.map samplePictures (Time.timestamp Mouse.isDown)


samplePictures : (Time.Time, Bool) -> List Picture
samplePictures (t, _) =
  let
    sec = Time.inSeconds t |> floor
    seed = Random.initialSeed sec    
    (p, seed') = Random.generate (Random.list 10 Awesome.Random.picture) seed
  in
    p
