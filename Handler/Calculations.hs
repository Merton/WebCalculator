{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handler.Calculations where

import Foundation
import Yesod
import Database.DBConnection


getCalculationsR :: Handler TypedContent
getCalculationsR = selectRep $ do
    provideRep $ defaultLayout $ do
        setTitle "Calculations"
        calculations <- liftIO (getRecords)
        [whamlet|
        $if null calculations
            <p> No Calculations <p>
        $else
            <ol>
                $forall calculation <- calculations
                    <li>#{calculation} |]
