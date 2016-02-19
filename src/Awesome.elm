module Awesome where

import Signal exposing (..)
import Random
import Awesome.Random
import Awesome.Model exposing (..)
import Awesome.View exposing (..)
import Time


main =
  Signal.map view gameState


gameState : Signal.Signal (List Picture)
gameState =
  Signal.map samplePictures (Time.every Time.second)


samplePictures : Time.Time -> List Picture
samplePictures t =
  let
    sec = Time.inSeconds t |> floor
    seed = Random.initialSeed sec    
    (p, seed') = Random.generate (Random.list 10 Awesome.Random.picture) seed
  in
    p
