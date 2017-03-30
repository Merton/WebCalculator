{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handler.Divide where

import Foundation
import Yesod.Core
import CalcStructure
import Database.DBConnection (insertRecord)

getDivideR :: Int -> Int -> Handler TypedContent
getDivideR x y = do
  liftIO (insertRecord c)
  selectRep $ do
    provideRep $ defaultLayout $ do
        setTitle "Divide"
        [whamlet|<p> The result of the calculation is: </p> #{x} / #{y} = #{z}|]
    provideJson $ c
  where
    z = x `div` y
    c = (Calculation x "/" y z)
