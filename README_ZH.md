# littlelambda

简易的无类型 lambda 演算化简器，使用 Normalization by Evaluation 算法。

## 构建

``` bash
ghc -o Main Main.hs
```

## 使用

我们在这里定义 lambda 项为：

$$
term := x|A\ B|\lambda x.M|let\ x=M;y
$$

其中 `let` 一项是为了方便定义新变量设置的语法糖。

## Test

``` bash
cat test.txt | Main
```

输出结果为邱奇编码下的数字 1000
