{-# LANGUAGE OverloadedStrings #-}

module DBConnection where

import Control.Applicative
import qualified Data.Text as T
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import CalcStructure

instance FromRow Calculation where
  fromRow = Calculation <$> field <*> field <*> field <*> field

instance ToRow Calculation where
  toRow (Calculation firstOp operator secondOp result) = toRow (firstOp, operator, secondOp, result)
{-
insertRecord :: Calculation -> IO (Maybe String)
insertRecord (x o y z) = insertRow dbHandler calculations newRecord
  where dbHandler = openConnection calculationsDB
  -}
    {-    newRecord = Row [(),("firstOp",x),("Operator", o),("secondOp",y),("result",z)]
-}

insertRecord :: Calculation -> IO ()
insertRecord (Calculation x o y z) = do
  conn <- open "calculations.db"
  execute conn "INSERT INTO calculations (firstOp, operator, secondOp, result) VALUES (?,?,?,?)" (Calculation x o y z)
  rowId <- lastInsertRowId conn
  close conn

initialiseDB :: String -> IO ()
initialiseDB db = do
  conn <- open db
  execute_ conn "CREATE TABLE IF NOT EXISTS calculations (id INTEGER PRIMARY KEY, firstOp INTEGER, operator TEXT, secondOp INTEGER, result INTEGER)"
  close conn
