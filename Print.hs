module Print where

import Base

instance Show Expr where
    show (Var (Name x))     = x
    show (Lam (Name x) m)   = "λ" ++ x ++ "." ++ (show m)
    show (App x y)          = (show x) ++ " " ++ (show y)
    show (Let (Name x) m y) = "Let " ++ x ++ "=" ++ (show m) ++ ";" ++ (show y)
