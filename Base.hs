open Base where

data Name = Name String

data Expr
    = Var Name
    | App Expr Expr
    | Lam Name Expr
    | Let Name Expr Expr

newtype Env = [(Name, Value)]
newtype Closure = Env Expr

data Value
    = VLam Closure
    | Vneutral Neutral

data Neutral
    = NVar Name
    | NApp Neutral Value
