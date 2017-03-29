{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Subtract where

import Foundation
import Yesod.Core
import CalcStructure
import DBConnection (insertRecord)

getSubtractR :: Int -> Int -> Handler TypedContent
getSubtractR x y = do
  liftIO (insertRecord c)
  selectRep $ do
    provideRep $ defaultLayout $ do
        setTitle "Subtract"
        [whamlet|<p> The result of the calculation is: </p> #{x} - #{y} = #{z}|]
    provideJson $ c
  where
    z = x - y
    c = (Calculation x "-" y z)
