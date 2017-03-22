module DBConnection where

import Database.SQLite



insertRecord :: Calculation
insertRecord (x o y z) = insertRow db calculations Row [()]
  where db = openConnection calculationsDB
