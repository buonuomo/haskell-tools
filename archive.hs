{- A program a that creates a folder or folders for a given id string (eg. 16),
    and moves all files containing that id string into the folder 

    Eg. >>> ./archive 3
        creates directory 'day-3' if it doesnt already exist, and moves all
        files in current directory containing '3' in their name to day-3.

   Author: Noah Goodman, 2017
-}

module Main where

import System.Directory
import System.FilePath ((</>))
import System.Environment (getArgs)
import Control.Monad (guard,filterM)
import Data.List (subsequences)

-- Function that turns id string into name of directory
dayDir :: String -> FilePath
dayDir day = "day-" ++ day

-- Creates a given directory if not already there
makeDayDir :: String -> IO ()
makeDayDir day = createDirectoryIfMissing True (dayDir day)

-- Test to see if a filename contains the id string
containsDay :: String -> String -> Bool
containsDay day file = day `elem` subsequences file 

-- Builds up a list of pairs of ids and lists of matching files, and then
-- creates directories and moves files to them accordingly
main :: IO ()
main = do
    args <- getArgs
    case args of 
      [] -> putStrLn "Usage: archive [id_strings]"
      _  -> do
          files <- filterM doesFileExist =<< listDirectory "."
          let archives = [(day,file) | day <- args, file <- files, containsDay day file]
          mapM makeDayDir args
          mapM_ (\(day,file) -> renamePath file (dayDir day </> file)) archives
