module Awesome.Model where

import Matrix exposing (..)

import List as L exposing (..)
import Maybe
import Random

type Block
  = Black
  | White
  | Blue
  | Yellow
  | Red

type alias Picture = Matrix (Maybe Block)

allBlocks : List Block
allBlocks = [Black, White, Blue, Yellow, Red]