{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Calculations where

import Foundation
import Yesod.Core
import CalcStructure
import DBConnection

{-
getCalculationsR :: Handler TypedContent
getCalculationsR = selectRep $ do
    provideRep $ defaultLayout $ do
        setTitle "Calculations"
    provideJson $ c
  where

    c = liftIO (getRecords)
-}
