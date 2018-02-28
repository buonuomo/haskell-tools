module Main where

import System.Directory
import System.Environment (getArgs)
import Control.Monad (guard,filterM)
import Data.List (subsequences)

dayDir :: String -> FilePath
dayDir day = "day-" ++ day

makeDayDir :: String -> IO ()
makeDayDir day = createDirectoryIfMissing True (dayDir day)

containsDay :: String -> String -> Bool
containsDay day file = day `elem` subsequences file 

main :: IO ()
main = do
    args <- getArgs
    files <- filterM doesFileExist =<< listDirectory "."
    let archives = [(day,file) | day <- args, file <- files, containsDay day file]
    mapM makeDayDir args
    mapM_ (\(day,file) -> renamePath file (dayDir day ++ "\\" ++ file)) archives
