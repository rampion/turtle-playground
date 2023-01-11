module TurtlePlayground.Prelude 
  ( module TurtlePlayground.Prelude
  , module Prelude
  , module Turtle.Prelude
  , module Turtle
  , module Data.Text
  )
where

import Prelude hiding (FilePath)
import Turtle.Prelude
import Turtle (FilePath, Line, Shell)
import Data.Text (Text)

import Data.Text qualified as Text

tshow :: Show a => a -> Text
tshow = Text.pack . show
