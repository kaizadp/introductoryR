Basic Univariate Statistics – LME
================

This tutorial will walk you through Linear Mixed Effects Models (LME).

### What is an LME/LMM?

Linear mixed effects models (linear mixed models) allow us to use fixed
as well as random variables in our linear model. A random effect is
something we want to control for, but not include as a primary
explanatory effect (fixed).

This has practical applications for soil science/environmental science
experiments where the same sample might be analyzed multiple times,
e.g. before vs. after homogenization, before vs. after a treatment, or
co-located split plots. In such cases, the treatment (homogenization,
etc.) becomes the fixed variable, and the sample number becomes the
random variable.

------------------------------------------------------------------------

### Packages

The `{nlme}` and `{lme4}` packages are commonly used to perform LME.

We will use the `{nlme}` package for this tutorial. This package comes
with a pre-loaded dataset, `Orthodont`

``` r
library(nlme)
head(Orthodont)
```

    ## Grouped Data: distance ~ age | Subject
    ##   distance age Subject  Sex
    ## 1     26.0   8     M01 Male
    ## 2     25.0  10     M01 Male
    ## 3     29.0  12     M01 Male
    ## 4     31.0  14     M01 Male
    ## 5     21.5   8     M02 Male
    ## 6     22.5  10     M02 Male

------------------------------------------------------------------------

### LME example

Each subject (M01-M16, F01-F13) was measured for orthodontic distance at
different ages. You can get detailed info about the dataset using
`?Orthodont` in your console.

Given the structure of this dataset, we would expect `distance` to vary
with age and sex. However, each subject could also introduce
variability, so we control for it by using `subject` as a random factor.

The LME setup is like a typical univariate model, y \~ x, but with the
addition of the random effect

``` r
l = lme(distance ~ age * Sex, random = ~1|Subject, data = Orthodont)
print(l)
```

    ## Linear mixed-effects model fit by REML
    ##   Data: Orthodont 
    ##   Log-restricted-likelihood: -216.8786
    ##   Fixed: distance ~ age * Sex 
    ##   (Intercept)           age     SexFemale age:SexFemale 
    ##    16.3406250     0.7843750     1.0321023    -0.3048295 
    ## 
    ## Random effects:
    ##  Formula: ~1 | Subject
    ##         (Intercept) Residual
    ## StdDev:    1.816214 1.386382
    ## 
    ## Number of Observations: 108
    ## Number of Groups: 27

``` r
summary(l)
```

    ## Linear mixed-effects model fit by REML
    ##   Data: Orthodont 
    ##        AIC      BIC    logLik
    ##   445.7572 461.6236 -216.8786
    ## 
    ## Random effects:
    ##  Formula: ~1 | Subject
    ##         (Intercept) Residual
    ## StdDev:    1.816214 1.386382
    ## 
    ## Fixed effects:  distance ~ age * Sex 
    ##                   Value Std.Error DF   t-value p-value
    ## (Intercept)   16.340625 0.9813122 79 16.651810  0.0000
    ## age            0.784375 0.0775011 79 10.120823  0.0000
    ## SexFemale      1.032102 1.5374208 25  0.671321  0.5082
    ## age:SexFemale -0.304830 0.1214209 79 -2.510520  0.0141
    ##  Correlation: 
    ##               (Intr) age    SexFml
    ## age           -0.869              
    ## SexFemale     -0.638  0.555       
    ## age:SexFemale  0.555 -0.638 -0.869
    ## 
    ## Standardized Within-Group Residuals:
    ##         Min          Q1         Med          Q3         Max 
    ## -3.59804400 -0.45461690  0.01578365  0.50244658  3.68620792 
    ## 
    ## Number of Observations: 108
    ## Number of Groups: 27

To get p-values and determine if the fixed effects were significant, we
use an ANOVA on the LME. There are two ways to do so, both give the same
results.

``` r
anova(l)
```

``` r
anova.lme(l)
```

    ##             numDF denDF  F-value p-value
    ## (Intercept)     1    79 4123.156  <.0001
    ## age             1    79  122.450  <.0001
    ## Sex             1    25    9.292  0.0054
    ## age:Sex         1    79    6.303  0.0141

#### Reporting these results

When reporting these results in a manuscript, etc., include the test
name, the statistic, and the p-value.

For example: YY was significantly influenced by XX (LME, F = aaaa, P =
bbbb)
