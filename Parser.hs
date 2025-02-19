module Parser where

import Base
import Control.Applicative
import Data.Char

newtype Parser x = Parser { parser :: String -> Maybe(x, String) }

doPrase :: Parser x -> String -> Maybe(x, String)
doPrase (Parser p) x = p x

instance Functor Parser where
    fmap f (Parser ps) = Parser $ \p ->
        case ps p of
            Nothing -> Nothing
            Just (x, y) -> Just(f x, y)

instance Applicative Parser where
    pure x = Parser $ \s -> Just(x, s)
    (Parser p1) <*> (Parser p2) = Parser $ \p ->
        case p1 p of
            Nothing -> Nothing
            Just(f, s1) -> case p2 s1 of
                Nothing -> Nothing
                Just (a, s2) -> Just(f a, s2)

instance Monad Parser where
    return = pure
    ps >>= f = Parser $ \p ->
        case doPrase ps p of
            Nothing -> Nothing
            Just(a, s) -> doPrase (f a) s

instance Alternative Parser where
    empty = Parser $ const Nothing
    (Parser p1) <|> (Parser p2) = Parser $ \p ->
        case p1 p of
            Nothing -> p2 p
            x -> x

item :: Parser Char
item = Parser $ \s ->
    case s of
        [] -> Nothing
        (x : xs) -> Just(x, xs)

satisfy :: (Char -> Bool) -> Parser Char
satisfy f = item >>= \c -> if f c then return c else empty

char :: Char -> Parser Char
char c = satisfy (== c)

isLambda :: Parser Char
isLambda = satisfy (== 'λ')

between :: Parser s -> Parser x -> Parser e -> Parser x
between s x e = s *> x <* e

skip :: Parser s -> Parser ()
skip p = many p >> return ()

pBucket p = between (char '(') p (char ')')

string :: String -> Parser String
string [] = return []
string (x : xs) = do
    s <- char x
    ss <- string xs
    return (s : ss)

pName :: Parser Name
pName = do
    skip (char ' ')
    x <- some (satisfy isAlphaNum)
    skip (char ' ')
    return $ Name x

pAtom :: Parser Expr
pAtom = (Var <$> pName) <|> pBucket pExpr

pSpine :: Parser Expr
pSpine = foldl1 App <$> some pAtom

pLam :: Parser Expr
pLam = do
    char 'λ'
    xs <- some pName
    char '.'
    m  <- pExpr
    return $ foldr Lam m xs

pLet :: Parser Expr
pLet = do
    string "let"
    x <- pName
    char '='
    m <- pExpr
    char ';'
    y <- pExpr
    return $ Let x m y

pExpr :: Parser Expr
pExpr = pLam <|> pLet <|> pSpine
