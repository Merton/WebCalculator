{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Add where

import Foundation
import Yesod.Core
import CalcStructure
import DBConnection (insertRecord)

getAddR :: Int -> Int -> Handler TypedContent
getAddR x y = do
  liftIO (insertRecord c)
  selectRep $ do
    provideRep $ defaultLayout $ do
        setTitle "Addition"
        [whamlet|<p> The result of the calculation is: </p> #{x} + #{y} = #{z}|]
    provideJson $ c
  where
    z = x + y
    c = (Calculation x "+" y z)
