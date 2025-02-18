module Main where

import Base
import Eval

main = do
    print (readBack [] (eval [] (App (Lam (Name "x") (Var (Name "x"))) (Var (Name "x")))) )
