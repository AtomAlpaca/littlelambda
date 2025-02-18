module Eval where

import Base
import Data.Maybe
import Data.List

doApply :: Value -> Value -> Value
doApply (VLam (Closure e m) x) y = eval ((x, y) : e) m
doApply (VNeutral x) y = VNeutral (NApp x y)

eval :: Env -> Expr -> Value
eval e (Var v) = fromJust $ lookup v e
eval e (App u v) = doApply (eval e u) (eval e v)
eval e (Lam x m) = VLam (Closure e m) x
eval e (Let x m y) = eval e' m where e' = ((x, (eval e m)) : e)

newVar :: [String] -> String
newVar ns = newVarHelper ns "x"

newVarHelper :: [String] -> String -> String
newVarHelper ns x = case elem x ns of
    True -> newVarHelper ns (x ++ "'")
    False -> x

readBack :: [String] -> Value -> Expr
readBack ns v = case v of
    VLam (Closure e m) x -> Lam (Name y) (readBack (y : ns) (doApply v (VNeutral (NVar (Name y)))))
        where y = newVar ns
    VNeutral x -> readBackNeu ns x

readBackNeu :: [String] -> Neutral -> Expr
readBackNeu ns (NVar x)   = Var x
readBackNeu ns (NApp x y) = App (readBackNeu ns x) (readBack ns y)
