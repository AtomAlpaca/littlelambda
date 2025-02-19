module Main where

import Base
import Eval
import Print
import Parser

main = do
    src <- getContents
    putStrLn $ case (doPrase pExpr src) of
        Nothing -> "Error"
        Just (expr, _) -> show $ readBack [] (eval [] expr)
