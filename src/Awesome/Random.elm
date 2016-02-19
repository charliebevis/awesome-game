module Awesome.Random
  ( picture
  , block
  ) where

import Awesome.Model exposing (Block(..), Picture)
import Random exposing (..)
import Matrix.Random

between i (x, y) =
  i >= x && i < y

picture : Generator Picture
picture =
  Matrix.Random.matrix
    (int 3 4)
    (int 3 4)
    element

element : Generator (Maybe Block)
element =
  map2 (\isEmpty b ->
    if isEmpty `between` (0, 40) then
      Nothing
    else
      Just b
  ) (int 1 100) block

block : Generator Block
block =
  map (\i ->
    if i `between` (0, 20) then
      Blue
    else
    if i `between` (21, 40) then
      Black
    else
    if i `between` (41, 60) then
      Yellow
    else
    if i `between` (61, 80) then
      White
    else
      Red
  ) (int 1 100)
