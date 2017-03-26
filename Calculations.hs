{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Calculations where

import Foundation
import Yesod.Core
import CalcStructure
import DBConnection


getCalculationsR :: Handler TypedContent
getCalculationsR = do
  provideRep $ defaultLayout $ return
      setTitle "Calculations"
  provideJson calculations
    where
      calculations = getRecords 
