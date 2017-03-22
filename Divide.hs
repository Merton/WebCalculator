{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Divide where

import Foundation
import Yesod.Core
import CalcStructure

getDivideR :: Int -> Int -> Handler TypedContent
getDivideR x y = selectRep $ do
    provideRep $ defaultLayout $ do
        setTitle "Divide"
        [whamlet|<p> The result of the calculation is: </p> #{x} / #{y} = #{z}|]
    provideJson $ c
  where
    z = x `div` y
    c = (Calculation x "/" y z)