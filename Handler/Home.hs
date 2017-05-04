{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
module Handler.Home where

import Foundation
import Yesod.Core
import CalcStructure


--import DBConnection
getHomeR :: Handler Html
getHomeR = defaultLayout $ do
  setTitle "Haskell Web Calculator API"
  addStylesheetRemote "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
  addStylesheetRemote "http://fonts.googleapis.com/css?family=Strait"
  addScript $ StaticR form_js
  addStylesheet $ StaticR layoutCSS_css
  $(whamletFile "templates/layout.html")
  $(whamletFile "templates/home.html")
