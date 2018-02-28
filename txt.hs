module Main where

import System.Directory
import Control.Monad (guard)

isHask :: FilePath -> Bool
isHask = (=="sh.") . take 3 . reverse

replaceHs :: FilePath -> FilePath
replaceHs = reverse . ("txt." ++) . drop 3 . reverse

main = do 
    ls <- listDirectory "."
    let txts = [(orig,txt) | orig <- ls, isHask orig, let txt = replaceHs orig]
    mapM_ (uncurry copyFile) txts   
