module Main where

import Base
import Eval
import Print
import Parser

main = do
    print $ show $ readBack [] (eval [] (App (Lam (Name "x") (Var (Name "x"))) (Lam (Name "x") (Var (Name "x")))))
    print $ doPrase isLambda "λ"
    print $ show $ doPrase pName "name  sss"
    print $ show $ doPrase pExpr "λx y.x y"
