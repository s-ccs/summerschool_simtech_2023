# Multiple Regression Basics

## Motivation

### Introductory Example: tree dataset from R

[figure of raw data]

*Aim:* Find relationship between the *response variable* `volume`  and the *explanatory variable/covariate* `girth`?
Can we predict the volume of a tree given its girth?

[figure including a straight line]

First Guess: There is a linear relation!


## Simple Linear Regression

Main assumption: up to some error term, each measurement of teh response variable $y_i$ depends linearly on the corresponding value $x_i$ of the covariate

=> **(Simple) Linear Model**
$$y_i = \beta_0 + \beta_1 x_i + \varepsilon_i,   \qquad  i=1,...,n,$$
where $\varepsilon_i \sim \mathcal{N}(0,\sigma^2)$ are independent normally distributed errors with unknown variance $\sigma^2$.

*Task:* Find the straight line that fits best, i.e., find the *optimal* estimators for $\beta_0$ and $\beta_1$.

*Typical choice*: Least squares estimator (= maximum likelihood estimator for normal errors)
```math
(\hat \beta_0, \hat \beta_1) = \mathrm{argmin} \ \| \mathbf{y} - \mathbf{1} \beta_0 - \mathbf{x} \beta_1\|^2
```
where $\mathbf{y}$ is the vector of responses, $\mathbf{x}$ is the vector of covariates and $\mathbf{1}$ is a vector of ones.

Written in matrix style:
```math
(\hat \beta_0, \hat \beta_1) = \mathrm{argmin} \ \| \mathbf{y} - (\mathbf{1},\mathbf{x}) \left( \begin{array}{c} \beta_0\\ \beta_1\end{array}\right) \|^2
```
Note: There is a closed-form expression for $(\hat \beta_0, \hat \beta_1)$. We will not make use of it here, but rather use Julia to solve the problem.

[use Julia code (existing package) to perform linear regression for ``volume ~ girth``]

*Interpretation of the Julia output:* 
+ column ``estimate`` : least square estimates for $\hat \beta_0$ and $\hat \beta_1$
+ column ``Std. Error`` : estimated standard deviation $s_\beta$ of the estimators
+ column ``t value`` : value of the $t$-statistics
  ```math
   t_i = \hat \beta_i \over s_{\beta_i}, \quad i=0,1,
   ```
  Under the hypothesis $\beta_i=0$, $t_i$ would follow a $t$-distribution.
+ column ``Pr(>|t|)'': $p$-values for the hyptheses $\beta_i=0$ for $i=0,1$ 

**Exercise**: Generate a random set of covariates $\mathbf{x}$. Given these covariates and true parameters $\beta_0$, $\beta_1$ and $\sigma^2$ (you can choose them)), simulate responses from a linear model
```math
(\hat \beta_0, \hat \beta_1) = \mathrm{argmin} \ \| \mathbf{y} - \mathbf{1} \beta_0 - \mathbf{x} \beta_1\|^2
```
and estimate the coefficients $\beta_0$ and $\beta_1$. Play with different choices of the parameters to see the effects on the parameter estimates and the $p$-values. 

## Multiple Regression Model

*Idea*: Generalize the simple linear regression model to multiple covariates, w.g., predict ``volume`` using ``girth`` and `height``.

=> **Linear Model**
$$y_i = \beta_0 + \beta_1 x_{i1} + \ldots + \beta_p x_{ip} + \varepsilon_i,   \qquad  i=1,...,n,$$
where 
+ $y_i$: $i$ th measurement of the response,
+ $x_{i1}$: $i$ th value of first covariate,
...
+ $x_{ip}$: $i$ th value of $p$-th covariate,
+ $\varepsilon_i \sim \mathcal{N}(0,\sigma^2)$: independent normally distributed errors with unknown variance $\sigma^2$.

*Task:* Find the *optimal* estimators for $\beta_0, \beta_1, \ldots, \beta_p$.

*Our choice again:* Least squares estimator (= maximum likelihood estimator for normal errors)
```math
(\hat \beta_0, \hat \beta_1, \ldots, \beta_p) = \mathrm{argmin} \ \| \mathbf{y} - \mathbf{1} \beta_0 - \mathbf{x}_1 \beta_1 - \mathbf{x}_p \beta_p\|^2
```
where $\mathbf{y}$ is the vector of responses, $\mathbf{x}$_j is the vector of the $j$ th covariate and $\mathbf{1}$ is a vector of ones.

Written in matrix style:
```math
\mathbf{\hat \beta} = \mathrm{argmin} \ \| \mathbf{y} - (\mathbf{1},\mathbf{x}_1,\ldots,\mathbf{x}_p) \left( \begin{array}{c} \beta_0 \\ \beta_1 \\ \vdots \\ x_p\end{array} \right) \|^2
```

Defining the *design matrix* $\mathbf{X}$ (size $n \times (p+1)$), we get the short form
```math
\mathbf{\hat \beta} = \mathrm{argmin} \ \| \mathbf{y} - \mathbf{X} \mathbf{\beta}  \|^2 = (\mathbf{X}^\top \mathbf{X})^{-1} \mathbf{X}^\top \mathbf{y}
```

[use Julia code (existing package) to perform linear regression for ``volume ~ girth + height``]

Interpretation of the Julia output is similar to the simple linear regression model, but we provide explicit formulas now:
+ parameter estimates
+ estimated standard errors
+ $t$-statistics
+ $p$-values

 **Exercise**: Implement functions that estimate the $\beta$-parameters, the corresponding standard errors and the $t$-statistics.
 Test your functions with the ```tree''' data set and try to reproduce the output above.


 ## Potential Add-on: Multiple Regression Models with Categorical Covariates
