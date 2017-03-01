{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Subtract where

import Foundation
import Yesod.Core

getSubtractR :: Int -> Int -> Handler TypedContent
getSubtractR x y = selectRep $ do
    provideRep $ defaultLayout $ do
        setTitle "Subtract"
        [whamlet|#{x} - #{y} = #{z}|]
    provideJson $ object ["result" .= z]
  where
    z = x - y
