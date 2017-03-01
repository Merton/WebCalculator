{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Home where

import Foundation
import Yesod.Core

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "Minimal Multifile"
    [whamlet|
        <h> Basic Operations using Haskell Backend, delivered in JSON and HTML </h>
        <p>
            <a href=@{AddR 5 7}>HTML addition
        <p>
            <a href=@{MultiplyR 5 7}>HTML multiplication
        <p>
            <a href=@{AddR 5 7}?_accept=application/json>JSON addition
    |]
