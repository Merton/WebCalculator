{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module Handler.Home where

import Foundation
import Yesod.Core
import Yesod.Auth
import Yesod.Auth.BrowserId
import Yesod.Auth.GoogleEmail2
import Data.Default (def)
import Data.Text (Text)
import Network.HTTP.Client.Conduit (Manager, newManager)


-- Google client ID.
clientId :: Text
clientId = " 772476378204-51peif4ec0vhe9mlq7hel1augk90o291.apps.googleusercontent.com "

--  Google secret ID.
clientSecret :: Text
clientSecret = " g0U2BtaY-hXpNDT0yg9wE13T "

data App = App
    { httpManager :: Manager
    }

instance Yesod App where
        -- Note: In order to log in with BrowserID, you must correctly
        -- set your hostname here.
    approot = ApprootStatic "http://localhost:3000"

instance YesodAuth App where
    type AuthId App = Text
    getAuthId = return . Just . credsIdent

    loginDest _ = HomeR
    logoutDest _ = HomeR

    authPlugins _ =
          [ authBrowserId def
          , authGoogleEmail clientId clientSecret
          ]

    authHttpManager = httpManager

        -- The default maybeAuthId assumes a Persistent database. We're going for a
        -- simpler AuthId, so we'll just do a direct lookup in the session.
    maybeAuthId = lookupSession "_ID"

instance RenderMessage App FormMessage where
    renderMessage _ _ = defaultFormMessage

getHomeR :: Handler Html
getHomeR = do
  maid <- maybeAuthId
  defaultLayout $ do
  setTitle "Haskell Web Calculator API"
  addStylesheetRemote "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
  $(whamletFile "templates/home.html")
