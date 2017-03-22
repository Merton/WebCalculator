{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Add where

import Foundation
import Yesod.Core
import CalcStructure

getAddR :: Int -> Int -> Handler TypedContent
getAddR x y = selectRep $ do
    provideRep $ defaultLayout $ do
        setTitle "Addition"
        [whamlet|#{x} + #{y} = #{z}|]
    provideJson $ c
  where
    z = x + y
    c = (Calculation x "+" y z)
