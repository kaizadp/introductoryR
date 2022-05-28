Basic Univariate Statistics
================

This tutorial will walk you through basic statistical tools like ANOVA
and LME

------------------------------------------------------------------------

We will use the `{palmerpenguins}` package for this exercise.

First, load the package.

``` r
library(palmerpenguins)
str(penguins)
```

    ## tibble [344 × 8] (S3: tbl_df/tbl/data.frame)
    ##  $ species          : Factor w/ 3 levels "Adelie","Chinstrap",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ island           : Factor w/ 3 levels "Biscoe","Dream",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ bill_length_mm   : num [1:344] 39.1 39.5 40.3 NA 36.7 39.3 38.9 39.2 34.1 42 ...
    ##  $ bill_depth_mm    : num [1:344] 18.7 17.4 18 NA 19.3 20.6 17.8 19.6 18.1 20.2 ...
    ##  $ flipper_length_mm: int [1:344] 181 186 195 NA 193 190 181 195 193 190 ...
    ##  $ body_mass_g      : int [1:344] 3750 3800 3250 NA 3450 3650 3625 4675 3475 4250 ...
    ##  $ sex              : Factor w/ 2 levels "female","male": 2 1 1 NA 1 2 1 2 NA NA ...
    ##  $ year             : int [1:344] 2007 2007 2007 2007 2007 2007 2007 2007 2007 2007 ...

There are NAs scattered throughout the dataset. For easy statistical
modeling for this exercise, we clean the dataset by dropping the NAs.
(see the tidyverse tutorial for more info on `drop_na()`.)

``` r
library(tidyverse)
penguins_clean = penguins %>% drop_na()
```

------------------------------------------------------------------------

## ANOVA (ANalysis Of VAriation)

### ANOVA using `aov()`

`aov()` is available as part of the pre-loaded `{stats}` package. This
is useful for ANOVA with one explanatory/independent variable. This
**should be avoided when you have two or more explanatory variables**.

The basic structure for this is:

``` r
aov(DEPENDENT_VARIABLE ~ EXPLANATORY_VARIABLE, data = DATAFRAME)
```

------------------------------------------------------------------------

**example: does bill length vary by species?**

In this example, we have only one *explanatory variable*, “species”

``` r
a = aov(bill_length_mm ~ species, data = penguins_clean)
summary(a)
```

    ##              Df Sum Sq Mean Sq F value Pr(>F)    
    ## species       2   7015    3508   397.3 <2e-16 ***
    ## Residuals   330   2914       9                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

The p-value is used to determine significance.

By default, we use 0.05 as the threshold (called “alpha level”).  
Because p &lt; 0.05, we say that *bill length varies significantly by
species*.

------------------------------------------------------------------------

**example: does bill length vary by species and sex?**

In this example, we have two *explanatory variables*, “species” and
“sex”.  
The basic structure remains the same.

``` r
a = aov(bill_length_mm ~ species + sex, data = penguins_clean)
summary(a)
```

    ##              Df Sum Sq Mean Sq F value Pr(>F)    
    ## species       2   7015    3508   649.1 <2e-16 ***
    ## sex           1   1136    1136   210.2 <2e-16 ***
    ## Residuals   329   1778       5                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Because p &lt; 0.05, we say that *bill length varies significantly by
species and sex*.

------------------------------------------------------------------------

**example: how do species and sex interact to influence bill length?**

In the above example, we look at individual effects, i.e. (a) Adelie
vs. Chinstrap vs. Gentoo and (b) male vs. female. But what about
interactive effects? e.g. A-m vs. A-f vs. C-m vs. C-f, etc.

That is done by using `:` to denote interaction between two terms.

``` r
a = aov(bill_length_mm ~ species + sex + species:sex, data = penguins)
```

For convenience, this can be shortened using `*`, which means “a + b +
a:b”.

``` r
a = aov(bill_length_mm ~ species * sex, data = penguins)
summary(a)
```

    ##              Df Sum Sq Mean Sq F value Pr(>F)    
    ## species       2   7015    3508 654.189 <2e-16 ***
    ## sex           1   1136    1136 211.807 <2e-16 ***
    ## species:sex   2     24      12   2.284  0.103    
    ## Residuals   327   1753       5                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 11 observations deleted due to missingness

We see there *isn’t* an interactive effect of species and sex.

------------------------------------------------------------------------

### ANOVA using `car::Anova()`

The `Anova()` function in `the {car}` package is a more reliable tool
when working with two or more explanatory variables. You can also use it
for single explanatory variables, and it will give similar results to
`aov()`.

``` r
library(car)
```

The basic structure for this is:

``` r
Anova(lm(DEPENDENT_VARIABLE ~ EXPLANATORY_VARIABLE, data = DATAFRAME), type = TYPE)
```

`lm()` is a linear model. We first fit a linear model, and then we run
an ANOVA.

Read
[this](https://www.r-bloggers.com/2011/03/anova-–-type-iiiiii-ss-explained/)
for an explanation on ANOVA/sums of squares types.

------------------------------------------------------------------------

**example: does bill length vary by species?**

``` r
l = lm(bill_length_mm ~ species, data = penguins_clean)
a = Anova(l)
print(a)
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: bill_length_mm
    ##           Sum Sq  Df F value    Pr(>F)    
    ## species   7015.4   2   397.3 < 2.2e-16 ***
    ## Residuals 2913.5 330                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

**example: does bill length vary by species and island?**

``` r
l = lm(bill_length_mm ~ island * sex, data = penguins_clean)
Anova(l)
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: bill_length_mm
    ##            Sum Sq  Df F value   Pr(>F)    
    ## island     1384.0   2 30.7309 5.89e-13 ***
    ## sex        1142.3   1 50.7283 6.79e-12 ***
    ## island:sex    6.2   2  0.1371   0.8719    
    ## Residuals  7363.3 327                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

------------------------------------------------------------------------

------------------------------------------------------------------------

## Tukey’s HSD (Honestly Significant Difference) Test

The ANOVAs we ran above will tell you if a variable exerted a
significant influence on the dependent variable, but will not tell you
the relationship among the levels.  
For instance, we know bill length was influenced by species, but we
don’t know how Adelie, Chinstrap, and Gentoo compared among themselves.

To get pairwise differences, we use Tukey’s HSD test. This is an example
of a “post-hoc” test, because it is performed after the main test (in
this case, ANOVA).

We will use the `HSD.test()` function in the `{agricolae}` package.

``` r
library(agricolae)
```

To do this, you must first run an ANOVA using `aov()`.  
*This does not work with `car::Anova()`.*

``` r
a = aov(bill_length_mm ~ species + sex, data = penguins)
h = HSD.test(a, "species")
h
```

    ## $statistics
    ##    MSerror  Df     Mean       CV
    ##   5.403748 329 43.99279 5.284039
    ## 
    ## $parameters
    ##    test  name.t ntr StudentizedRange alpha
    ##   Tukey species   3         3.329582  0.05
    ## 
    ## $means
    ##           bill_length_mm      std   r  Min  Max    Q25   Q50    Q75
    ## Adelie          38.82397 2.662597 146 32.1 46.0 36.725 38.85 40.775
    ## Chinstrap       48.83382 3.339256  68 40.9 58.0 46.350 49.55 51.075
    ## Gentoo          47.56807 3.106116 119 40.9 59.6 45.350 47.40 49.600
    ## 
    ## $comparison
    ## NULL
    ## 
    ## $groups
    ##           bill_length_mm groups
    ## Chinstrap       48.83382      a
    ## Gentoo          47.56807      b
    ## Adelie          38.82397      c
    ## 
    ## attr(,"class")
    ## [1] "group"

With a Tukey HSD test, different letters indicate significant
differences among the levels.

In this example, Chinstrap has the greatest bill length, followed by
Gentoo, and then Adelie. And all three species are significantly
different from the each other.

``` r
a = aov(bill_length_mm ~ island, data = penguins)
h = HSD.test(a, "island")
h
```

    ## $statistics
    ##    MSerror  Df     Mean       CV
    ##   25.36462 339 43.92193 11.46655
    ## 
    ## $parameters
    ##    test name.t ntr StudentizedRange alpha
    ##   Tukey island   3         3.329136  0.05
    ## 
    ## $means
    ##           bill_length_mm      std   r  Min  Max   Q25   Q50   Q75
    ## Biscoe          45.25749 4.772731 167 34.5 59.6 42.00 45.80 48.70
    ## Dream           44.16774 5.953527 124 32.1 58.0 39.15 44.65 49.85
    ## Torgersen       38.95098 3.025318  51 33.5 46.0 36.65 38.90 41.10
    ## 
    ## $comparison
    ## NULL
    ## 
    ## $groups
    ##           bill_length_mm groups
    ## Biscoe          45.25749      a
    ## Dream           44.16774      a
    ## Torgersen       38.95098      b
    ## 
    ## attr(,"class")
    ## [1] "group"

In this example, we tested pairwise differences among islands.  
Biscoe and Dream were both “a”, so we conclude that bill length did not
differ significantly between these two islands. But Torgersen is “b”,
which means bill lengths on Torgersen are significantly smaller than on
the other islands.

------------------------------------------------------------------------

------------------------------------------------------------------------

<details>
<summary>
Session Info
</summary>

Date Run: 2022-05-27

    ## R version 4.1.1 (2021-08-10)
    ## Platform: x86_64-apple-darwin17.0 (64-bit)
    ## Running under: macOS Catalina 10.15.7
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRblas.0.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ##  [1] agricolae_1.3-5      car_3.0-13           carData_3.0-4       
    ##  [4] forcats_0.5.1        stringr_1.4.0        dplyr_1.0.9         
    ##  [7] purrr_0.3.4          readr_2.1.2          tidyr_1.2.0         
    ## [10] tibble_3.1.5         ggplot2_3.3.6        tidyverse_1.3.1     
    ## [13] palmerpenguins_0.1.0
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] httr_1.4.2       jsonlite_1.7.2   modelr_0.1.8     shiny_1.7.1     
    ##  [5] assertthat_0.2.1 highr_0.9        cellranger_1.1.0 yaml_2.2.1      
    ##  [9] lattice_0.20-44  pillar_1.6.2     backports_1.2.1  glue_1.6.2      
    ## [13] digest_0.6.27    promises_1.2.0.1 rvest_1.0.1      colorspace_2.0-2
    ## [17] htmltools_0.5.2  httpuv_1.6.2     klaR_0.6-15      pkgconfig_2.0.3 
    ## [21] broom_0.8.0      labelled_2.8.0   haven_2.4.3      questionr_0.7.4 
    ## [25] xtable_1.8-4     scales_1.1.1     later_1.3.0      tzdb_0.1.2      
    ## [29] combinat_0.0-8   generics_0.1.0   ellipsis_0.3.2   withr_2.5.0     
    ## [33] cli_3.3.0        magrittr_2.0.3   crayon_1.4.1     readxl_1.4.0    
    ## [37] mime_0.11        evaluate_0.15    fs_1.5.2         fansi_0.5.0     
    ## [41] nlme_3.1-153     MASS_7.3-54      xml2_1.3.2       tools_4.1.1     
    ## [45] hms_1.1.0        lifecycle_1.0.1  munsell_0.5.0    reprex_2.0.1    
    ## [49] cluster_2.1.2    compiler_4.1.1   rlang_1.0.2      grid_4.1.1      
    ## [53] rstudioapi_0.13  miniUI_0.1.1.1   rmarkdown_2.14   gtable_0.3.0    
    ## [57] abind_1.4-5      DBI_1.1.1        AlgDesign_1.2.0  R6_2.5.1        
    ## [61] lubridate_1.8.0  knitr_1.39       fastmap_1.1.0    utf8_1.2.2      
    ## [65] stringi_1.7.6    Rcpp_1.0.8       vctrs_0.4.1      dbplyr_2.1.1    
    ## [69] tidyselect_1.1.1 xfun_0.31
