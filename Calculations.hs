{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Calculations where

import Foundation
import Yesod.Core
import CalcStructure
import DBConnection


postCalculationsR :: Calculation -> Handler TypedContent
postCalculationsR c = do
  provideRep $ defaultLayout $ do
      setTitle "Calculations"
      [whamlet|#{x} + #{y} = #{z}|]
  provideJson $ c
