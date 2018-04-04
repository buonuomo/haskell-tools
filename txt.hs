{- Simple program that copies all .hs files in current directory to .txt files
    of the same name. 

   I originally used this for a class which required printing out haskell source
    for handing in homework, since the printer could not print .hs files

   Author: Noah Goodman, 2017
-}

module Main where

import System.Directory
import Control.Monad (guard)

-- Checks if a file has the .hs extension
isHask :: FilePath -> Bool
isHask = (=="sh.") . take 3 . reverse

-- replaces .hs extension (or any two letter extension) with .txt
replaceHs :: FilePath -> FilePath
replaceHs = reverse . ("txt" ++) . drop 2 . reverse

-- Execution of the copying procedure in the current directory
main = do 
    ls <- listDirectory "."
    -- makes (key,value) pairs for files in current directory, where key == .hs
    -- file, and value == .txt file with same name
    let txts = [(orig,txt) | orig <- ls, isHask orig, let txt = replaceHs orig]
    mapM_ (uncurry copyFile) txts   
