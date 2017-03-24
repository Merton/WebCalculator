{-# LANGUAGE OverloadedStrings #-}

module DBConnection where

import Control.Applicative
import qualified Data.Text as T
import Database.SQLite.Simple
import CalcStructure
import Data.Foldable (forM_)

dbPath :: String
dbPath = "calculations.db"


insertRecord :: Calculation -> IO ()
insertRecord c = do
  conn <- open dbPath
  execute conn "INSERT INTO calculations (firstOp, operator, secondOp, result) VALUES (?,?,?,?)"  (c :: Calculation)
  close conn

getRecords :: IO [Calculation]
getRecords = do
  conn <- open dbPath
  cs <- query_ conn "SELECT * from calculations" :: IO [Calculation]
  close conn
  return cs

getRecord :: Int -> IO [Calculation]
getRecord i = do
  conn <- open dbPath
  c <- query conn "SELECT firstOp, operator, secondOp, result from calculations WHERE operator = ?" (Only("+" :: String)) :: IO [Calculation]
  close conn
  return c


initialiseDB :: IO ()
initialiseDB = do
  conn <- open dbPath
  execute_ conn "CREATE TABLE IF NOT EXISTS calculations (firstOp INTEGER, operator TEXT, secondOp INTEGER, result INTEGER)"
  close conn

deleteDB :: IO ()
deleteDB = do
  conn <- open dbPath
  execute_ conn "DROP TABLE calculations"
  close conn
