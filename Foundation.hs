{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE ViewPatterns      #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Foundation where

import Yesod
import Yesod.Auth
import Network.HTTP.Client.Conduit (Manager)
import           Data.Default                (def)
import           Data.Text                   (Text)
import           Yesod.Auth.BrowserId
import           Yesod.Auth.GoogleEmail2

data App = App
    { httpManager :: Manager
    }
-- Google client ID.
clientId :: Text
clientId = " 772476378204-51peif4ec0vhe9mlq7hel1augk90o291.apps.googleusercontent.com "

-- Google secret ID.
clientSecret :: Text
clientSecret = " g0U2BtaY-hXpNDT0yg9wE13T "

mkYesodData "App" $(parseRoutesFile "routes")

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
