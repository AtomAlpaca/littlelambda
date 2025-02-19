module Main where

import Base
import Eval
import Print

main = do
    print $ show $ readBack [] (eval [] (App (Lam (Name "x") (Var (Name "x"))) (Lam (Name "x") (Var (Name "x")))))
