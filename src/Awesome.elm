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
import String
import List exposing ((::))

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
    (time, key) = input.pressed

    regeneratePictures = Char.fromCode key == 'r'

    (chosenPicture, newAvailablePictures) =
      selectPicture key gs.availablePictures

    newPictures =
      if (regeneratePictures)
      then
        generatePictures time
      else
        newAvailablePictures

    newChosenPictures =
      case chosenPicture of
        Nothing ->
          gs.chosenPictures
        Just x ->
          x :: gs.chosenPictures
  in
    { gs
      | availablePictures = newPictures
      , chosenPictures = newChosenPictures
    }

selectPicture : Char.KeyCode -> List Picture -> (Maybe Picture, List Picture)
selectPicture key list =
  let
    resultantIndex = Char.fromCode key |> String.fromChar |> String.toInt
  in
    case resultantIndex of
      Err _ ->
        (Nothing, list)
      Ok i ->
        extract i list

extract : Int -> List a -> (Maybe a, List a)
extract i l =
  case l of
    [] ->
      (Nothing, [])
    hd::tl ->
      if i == 0
      then
        (Just hd, tl)
      else
        let
          (val, newL) = (extract (i - 1) tl)
        in
          (val, hd :: newL)
