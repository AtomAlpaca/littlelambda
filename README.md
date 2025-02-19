# littlelambda

A tiny untyped lambda calculus evaluatior with Normalization by Evaluation algorithm.

## build

``` bash
ghc -o Main Main.hs
```

## Usage

Here we define a lambda term as below

$$
term :=  x|A\ B|\lambda x.M|let\ x=M;y
$$

where the `let` pattern is a syntactic sugar for the convenience of defining variables.

## Test

``` bash
cat test.txt | Main
```

It would output the normal form of 1000 in Church encoding
