module Awesome where

import Signal exposing (..)
import Random
import Awesome.Random
import Awesome.Model exposing (..)
import Awesome.View exposing (..)
import Char
import Keyboard
import Time
import Mouse

type alias Input =
  { pressed: (Time.Time, Char.KeyCode)
  }

main =
  let
    inputs = Signal.map Input
                (Time.timestamp Keyboard.presses)

    gameSignal = Signal.foldp update newGame inputs
  in
    Signal.map viewGame gameSignal


newGame : GameState
newGame =
  { chosenPictures = []
  , availablePictures = generatePictures (Time.inSeconds 5.0)
  }

generatePictures : Time.Time -> List Picture
generatePictures t =
  let
    sec = Time.inMilliseconds t |> floor
    seed = Random.initialSeed sec
    (p, seed') = Random.generate (Random.list 10 Awesome.Random.picture) seed
  in
    p


update : Input -> GameState -> GameState
update input gs =
  let
    newPictures = generatePictures (input.pressed |> fst)
  in
    { gs |
      availablePictures = newPictures
    }
