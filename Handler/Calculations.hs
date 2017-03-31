{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handler.Calculations where

import Foundation
import Yesod
import Database.DBConnection
import CalcStructure
import Yesod.Table (Table)
import qualified Yesod.Table as Table

{-
calculationsTable :: Table site Calculation
calculationsTable = mempty
  ++ Table.int "First Operator"   (firstOp)
  ++ Table.string "Operator"         operator
  ++ Table.int "Second Operator"  (secondOp)
  ++ Table.int "Result"           (result)
-}
getCalculationsR :: Handler TypedContent
getCalculationsR = selectRep $ do
    provideRep $ defaultLayout $ do
        setTitle "Calculations"
        liftIO (initialiseDB)
        calculations <- liftIO (getRecords)
        --Table.buildBootstrap calculationsTable [ Calculation 5 "+" 10 15, Calculation 2 "*" 3 6]
        [whamlet|
        $if null calculations
          <h2> No calculations have been made! <h2>
        $else
          <table>
            <thead>
              <tr>
                <th>First Operator</th>
                <th>Operator</th>
                <th>Second Operator</th>
                <th>Result</th>
            <tbody>
              $forall c <- calculations
                <tr>
                  <td>#{firstOp c}
                  <td>#{operator c}
                  <td>#{secondOp c}
                  <td>#{result c}
|]
               {-
        $if null calculations
            <p> No Calculations <p>
        $else
            <ol>
                $forall calculation <- calculations
                    <li>#{calculation} |]
                    -}
