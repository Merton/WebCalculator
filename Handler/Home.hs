{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.Home where

import Foundation
import Yesod.Core

--import DBConnection

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
  setTitle "Haskell Web Calculator API"
  addStylesheetRemote "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
  $(whamletFile "templates/home.html")
