{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handler.Multiply where

import Foundation
import Yesod.Core
import CalcStructure
import Database.DBConnection (insertRecord)

getMultiplyR :: Int -> Int -> Handler TypedContent
getMultiplyR x y = do
  liftIO (insertRecord c)
  selectRep $ do
    provideRep $ defaultLayout $ do
        setTitle "Multiply"
        [whamlet|<p> The result of the calculation is: </p> #{x} * #{y} = #{z}|]
    provideJson $ c
  where
    z = x * y
    c = (Calculation x "*" y z)
