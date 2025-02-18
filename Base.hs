module Base where

data Name = Name String deriving (Show, Eq)

data Expr
    = Var Name
    | App Expr Expr
    | Lam Name Expr
    | Let Name Expr Expr
    deriving Show

type Env = [(Name, Value)]
data Closure = Closure Env Expr

data Value
    = VLam Closure Name
    | VNeutral Neutral

data Neutral
    = NVar Name
    | NApp Neutral Value
