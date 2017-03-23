{-# LANGUAGE DeriveGeneric #-}

module CalcStructure where

import Yesod.Core
import GHC.Generics

data Calculation = Calculation {
firstOp :: Int,
operator :: String,
secondOp :: Int,
result :: Int
} deriving (Generic)

instance ToJSON Calculation
