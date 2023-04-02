---
title: Self Aware
---

# A Classical Exercise

A computer program which produces its own source code is called a quine, named after the logician Willard Van Orman Quine.

**Exercise:** Write a quine in your favorite programming language.

If you haven't solved this exercise before, I urge you to stop right now and give it a try.

To give you an idea of why this is an interesting problem, let us try to solve it in a naive way. Instead of using an actual programming language
I will use pseudocode to keep things simple.

The obvious candidate of a quine is

```
Print your own source code
```

This looks like cheating but actually there are languages which allow this. For instance

```
10 List
```

is a valid GWBasic program which, when run, prints `10 List` on the screen. Actually, in GWBasic, *any* code which starts with `10 List`
is a quine.

So, to make things less trivial and more generic, let us restrict ourselves to text manipulations. In this case, the first candidate is
```
Print "Print"
```

The output of this code is simply `Print`. So it doesn't work. Seeing this, you may try
```
Print "Print "Print""
```

This time the output is `Print "Print"`. Failed again. Actually, any code of the form `Print "<any kind of fixed text>"` will fail
as the source code is strictly longer than the text it prints. Now here is an idea to circumvent this: We can use the the given text, or its parts, more than once!
So let us try a program like this:
```
Let A be the following text:
"<there is going to be a text here>"
<there are going to be commands here explaining what to do with A>
```

As we will construct the source code using the parts of the text A, the first line of the code should be a part of A. So our program should look like this:
```
Let A be the following text:
"Let A be the following text:
<there are going to be more lines here>"
<there are going to be commands here explaining what to do with A>
```

Of course, we will print the first line. Thus we should have a program like this:
```
Let A be the following text:
"Let A be the following text:
<there are going to be more lines here>"
Print the first line of A
<there are going to be more commands here>
```

Obviously the command `Print the first line of A` should appear somewhere in A. So let's add it to A to obtain

```
Let A be the following text:
"Let A be the following text:
Print the first line of A
<there are going to be more lines here>"
Print the first line of A
<there are going to be more commands here>
```

Now the second printing command should print what comes after the first line. But this is simply the text A in quotation. Therefore we should have

```
Let A be the following text:
"Let A be the following text:
Print the first line of A
<there are going to be more lines here>"
Print the first line of A
Print A in quotation
<there are going to be more commands here>
```

Again these commands should appear in A. So we have

```
Let A be the following text:
"Let A be the following text:
Print the first line of A
Print A in quotation
<there are going to be more lines here>"
Print the first line of A
Print A in quotation
<there are going to be more commands here>
```

Note that, up until now, all the steps we took were pretty much forced. The final step will be a little different and require a tid bit of creativity.
Here is our finished quine:

```
Let A be the following text:
"Let A be the following text:
Print the first line of A
Print A in quotation
Print A except for its first line"
Print the first line of A
Print A in quotation
Print A except for its first line
```

As an exercise, you may translate this quine into a real programming language. Even though the quine above has the essential idea, you may still need to deal with a few language specific details such as escaping quotation marks. Here is one for you in Haskell meant to be evaluated in repl.

```
let x = ["let x = ", " in putStr (x !! 0) >> putStr (show x) >> putStr (x !! 1)"] in putStr (x !! 0) >> putStr (show x) >> putStr (x !! 1)
```

Now this was fun, bu also ad-hoc. The natural question to ask here whether there is a principled way of writing, not only quines, but programs which have some kind of access to their own source code. The answer is yes and this follows from one of the most fundamental results in recursion theory, the recursion theorem.

# Kleene's Recursion Theorem

I want to work with a Turing complete programming language. Luckily, what we need is essentially what I described in the first section of
[Kolmogorov Complexity (1/2)](https://sonatsuer.github.io/kolmogorov-complexity/2018/05/21/kolmogorov-complexity-1.html). The differences
are that we do not need $\mathcal{L}$ to contain UTF-8 characters and we do not need an assumption on the way we represent natural numbers.

Let $\mathcal{M}$ be the set of all strings from $\mathcal{L}$ and let $\mathcal{C}(n)$ be the set of all source codes
expecting $n$ inputs, where $n$ is a natural number. Then, for each $c\in\mathcal{C}(n)$, we have a partial function $f_c$ from
$\mathcal{M}^n$ to $\mathcal{M}$, which is simply the partial function computed by the source code $c$. These functions are called the computable partial functions.

Let us start with a simple but useful lemma.

**Lemma:** There is a computable function $s$ such that for any $x\in\mathcal{M}$ and $c\in\mathcal{C}(2)$ we have
$s(c,x)\in\mathcal{C}(1)$ and
$$
   f_c(x,y) = f_{s(c,x)}(y).
$$
