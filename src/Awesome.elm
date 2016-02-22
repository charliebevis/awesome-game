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
  Signal.map samplePictures clickTime

clickTime : Signal Time.Time
clickTime = (Signal.map (\ (t,_) -> t) (Time.timestamp Mouse.clicks))

samplePictures : Time.Time -> List Picture
samplePictures t =
  let
    s = Time.inSeconds (t * 10) |> floor
    seed = Random.initialSeed s
    (p, seed') = Random.generate (Random.list 10 Awesome.Random.picture) seed
  in
    p
