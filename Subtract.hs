{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Subtract where

import Foundation
import Yesod.Core
import CalcStructure

getSubtractR :: Int -> Int -> Handler TypedContent
getSubtractR x y = selectRep $ do
    provideRep $ defaultLayout $ do
        setTitle "Subtract"
        [whamlet|#{x} - #{y} = #{z}|]
    provideJson $ c
  where
    z = x - y
    c = (Calculation x "+" y z)
