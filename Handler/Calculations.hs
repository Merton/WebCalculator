{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handler.Calculations where

import Foundation
import Yesod
import Database.DBConnection
import CalcStructure

getCalculationsR :: Handler TypedContent
getCalculationsR = do
  liftIO (initialiseDB)
  calculations <- liftIO (getRecords)
  selectRep $ do
    provideRep $ defaultLayout $ do
      setTitle "Calculations"
      addStylesheetRemote "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
      [whamlet|
      $if null calculations
        <h2> No calculations have been made! <h2>
      $else
        <h1> Every calculation ever made.</h1>
        <table class="table table-hover">
          <thead>
            <tr>
              <th>First Operand</th>
              <th>Operator</th>
              <th>Second Operand</th>
              <th>Result</th>
          <tbody>
            $forall c <- calculations
              <tr>
                <td>#{firstOp c}
                <td>#{operator c}
                <td>#{secondOp c}
                <td>#{result c}
      |]
    provideJson $ calculations
