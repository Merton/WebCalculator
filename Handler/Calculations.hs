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
getCalculationsR :: Handler Html
getCalculationsR = do
  liftIO (initialiseDB)
  calculations <- liftIO (getRecords)
  defaultLayout $ do
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
{-
postCalculationsR :: Calculation -> Handler TypedContent
postCalculationsR (Calculation x o y z) = do
  liftIO $ insertRecord (Calculation x o y z)
  selectRep $ do
    provideRep $ defaultLayout $ do
      setTitle "New Calculation Added"
      [whamlet|<p> The new calculation is: </p> #{x} #{o} #{y} = #{z}|]
    provideJson $ (Calculation x o y z)
-}
