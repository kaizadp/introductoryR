dplyr basics
================

``` r
library(tidyverse)
```

------------------------------------------------------------------------

We will use the `{dplyr}` built-in dataset `starwars`

<details>
<summary>
click here to explore the `starwars` dataset
</summary>

``` r
names(starwars)
```

    ##  [1] "name"       "height"     "mass"       "hair_color" "skin_color"
    ##  [6] "eye_color"  "birth_year" "sex"        "gender"     "homeworld" 
    ## [11] "species"    "films"      "vehicles"   "starships"

``` r
skimr::skim(starwars)
```

|                                                  |          |
|:-------------------------------------------------|:---------|
| Name                                             | starwars |
| Number of rows                                   | 87       |
| Number of columns                                | 14       |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |          |
| Column type frequency:                           |          |
| character                                        | 8        |
| list                                             | 3        |
| numeric                                          | 3        |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |          |
| Group variables                                  | None     |

Data summary

**Variable type: character**

| skim\_variable | n\_missing | complete\_rate | min | max | empty | n\_unique | whitespace |
|:---------------|-----------:|---------------:|----:|----:|------:|----------:|-----------:|
| name           |          0 |           1.00 |   3 |  21 |     0 |        87 |          0 |
| hair\_color    |          5 |           0.94 |   4 |  13 |     0 |        12 |          0 |
| skin\_color    |          0 |           1.00 |   3 |  19 |     0 |        31 |          0 |
| eye\_color     |          0 |           1.00 |   3 |  13 |     0 |        15 |          0 |
| sex            |          4 |           0.95 |   4 |  14 |     0 |         4 |          0 |
| gender         |          4 |           0.95 |   8 |   9 |     0 |         2 |          0 |
| homeworld      |         10 |           0.89 |   4 |  14 |     0 |        48 |          0 |
| species        |          4 |           0.95 |   3 |  14 |     0 |        37 |          0 |

**Variable type: list**

| skim\_variable | n\_missing | complete\_rate | n\_unique | min\_length | max\_length |
|:---------------|-----------:|---------------:|----------:|------------:|------------:|
| films          |          0 |              1 |        24 |           1 |           7 |
| vehicles       |          0 |              1 |        11 |           0 |           2 |
| starships      |          0 |              1 |        17 |           0 |           5 |

**Variable type: numeric**

| skim\_variable | n\_missing | complete\_rate |   mean |     sd |  p0 |   p25 | p50 |   p75 | p100 | hist  |
|:---------------|-----------:|---------------:|-------:|-------:|----:|------:|----:|------:|-----:|:------|
| height         |          6 |           0.93 | 174.36 |  34.77 |  66 | 167.0 | 180 | 191.0 |  264 | ▁▁▇▅▁ |
| mass           |         28 |           0.68 |  97.31 | 169.46 |  15 |  55.6 |  79 |  84.5 | 1358 | ▇▁▁▁▁ |
| birth\_year    |         44 |           0.49 |  87.57 | 154.69 |   8 |  35.0 |  52 |  72.0 |  896 | ▇▁▁▁▁ |

</details>

------------------------------------------------------------------------

# `{dplyr}` functions - the basics

## rename

Use this to rename columns.

general format:
`rename(dataframe, "NEW_COLUMN_NAME" = "OLD_COLUMN_NAME")`

You can rename multiple columns in the same command.

``` r
starwars_rn = rename(starwars, "NAME" = "name")
names(starwars_rn)
```

    ##  [1] "NAME"       "height"     "mass"       "hair_color" "skin_color"
    ##  [6] "eye_color"  "birth_year" "sex"        "gender"     "homeworld" 
    ## [11] "species"    "films"      "vehicles"   "starships"

``` r
starwars_rn2 = rename(starwars, 
                      "NAME" = "name",
                      "HEIGHT" = "height",
                      "MASS" = "mass")
names(starwars_rn2)
```

    ##  [1] "NAME"       "HEIGHT"     "MASS"       "hair_color" "skin_color"
    ##  [6] "eye_color"  "birth_year" "sex"        "gender"     "homeworld" 
    ## [11] "species"    "films"      "vehicles"   "starships"

``` r
starwars %>% 
  rename("NAME" = "name") %>% 
  names()
```

    ##  [1] "NAME"       "height"     "mass"       "hair_color" "skin_color"
    ##  [6] "eye_color"  "birth_year" "sex"        "gender"     "homeworld" 
    ## [11] "species"    "films"      "vehicles"   "starships"

``` r
starwars %>% 
  rename("NAME" = "name",
         "HEIGHT" = "height",
         "MASS" = "mass") %>% 
  names()
```

    ##  [1] "NAME"       "HEIGHT"     "MASS"       "hair_color" "skin_color"
    ##  [6] "eye_color"  "birth_year" "sex"        "gender"     "homeworld" 
    ## [11] "species"    "films"      "vehicles"   "starships"

## select

Use this to subset certain columns.

general format: \`select()

You can do this multiple ways:

-   choosing column names

``` r
starwars %>% 
  select(name, height, mass) %>% 
  head()
```

-   choosing column positions

``` r
starwars %>% 
  select(1:3) %>% 
  head()
```

-   deselecting column names/positions

``` r
starwars %>% 
  select(-(4:14)) %>% 
  head()
```

    ## # A tibble: 6 × 3
    ##   name           height  mass
    ##   <chr>           <int> <dbl>
    ## 1 Luke Skywalker    172    77
    ## 2 C-3PO             167    75
    ## 3 R2-D2              96    32
    ## 4 Darth Vader       202   136
    ## 5 Leia Organa       150    49
    ## 6 Owen Lars         178   120

## filter

Use `filter` to subset rows where certain conditions are met.

For example, filter only characters with black hair

``` r
starwars %>% 
  filter(hair_color == "black") %>% 
  head()
```

    ## # A tibble: 6 × 14
    ##   name     height  mass hair_color skin_color eye_color birth_year sex    gender
    ##   <chr>     <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr>  <chr> 
    ## 1 Biggs D…    183  84   black      light      brown           24   male   mascu…
    ## 2 Boba Fe…    183  78.2 black      fair       brown           31.5 male   mascu…
    ## 3 Lando C…    177  79   black      dark       brown           31   male   mascu…
    ## 4 Watto       137  NA   black      blue, grey yellow          NA   male   mascu…
    ## 5 Quarsh …    183  NA   black      dark       brown           62   <NA>   <NA>  
    ## 6 Shmi Sk…    163  NA   black      fair       brown           72   female femin…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

#### multiple conditions

For example, keep only characters with black or blond hair

``` r
starwars %>% 
  filter(hair_color %in% c("black", "blond")) %>% 
  head()
```

    ## # A tibble: 6 × 14
    ##   name      height  mass hair_color skin_color eye_color birth_year sex   gender
    ##   <chr>      <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Luke Sky…    172  77   blond      fair       blue            19   male  mascu…
    ## 2 Biggs Da…    183  84   black      light      brown           24   male  mascu…
    ## 3 Anakin S…    188  84   blond      fair       blue            41.9 male  mascu…
    ## 4 Boba Fett    183  78.2 black      fair       brown           31.5 male  mascu…
    ## 5 Lando Ca…    177  79   black      dark       brown           31   male  mascu…
    ## 6 Finis Va…    170  NA   blond      fair       blue            91   male  mascu…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

#### and/or conditions (multiple variables)

For example, keep only characters with black hair and blue eyes

``` r
starwars %>% 
  filter(hair_color == "black" & eye_color == "blue") %>% 
  head()
```

    ## # A tibble: 2 × 14
    ##   name      height  mass hair_color skin_color eye_color birth_year sex   gender
    ##   <chr>      <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Luminara…    170  56.2 black      yellow     blue              58 fema… femin…
    ## 2 Barriss …    166  50   black      yellow     blue              40 fema… femin…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

keep only characters with black hair *or* blue eyes

``` r
starwars %>% 
  filter(hair_color == "black" | eye_color == "blue") %>% 
  head()
```

    ## # A tibble: 6 × 14
    ##   name     height  mass hair_color  skin_color eye_color birth_year sex   gender
    ##   <chr>     <int> <dbl> <chr>       <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Luke Sk…    172    77 blond       fair       blue            19   male  mascu…
    ## 2 Owen La…    178   120 brown, grey light      blue            52   male  mascu…
    ## 3 Beru Wh…    165    75 brown       light      blue            47   fema… femin…
    ## 4 Biggs D…    183    84 black       light      brown           24   male  mascu…
    ## 5 Anakin …    188    84 blond       fair       blue            41.9 male  mascu…
    ## 6 Wilhuff…    180    NA auburn, gr… fair       blue            64   male  mascu…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

#### “not” conditions

keep only characters without black hair

``` r
starwars %>% 
  filter(hair_color != "black") %>% 
  head()
```

another notation for this is

``` r
starwars %>% 
  filter(!hair_color == "black") %>% 
  head()
```

    ## # A tibble: 6 × 14
    ##   name     height  mass hair_color  skin_color eye_color birth_year sex   gender
    ##   <chr>     <int> <dbl> <chr>       <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Luke Sk…    172    77 blond       fair       blue            19   male  mascu…
    ## 2 Darth V…    202   136 none        white      yellow          41.9 male  mascu…
    ## 3 Leia Or…    150    49 brown       light      brown           19   fema… femin…
    ## 4 Owen La…    178   120 brown, grey light      blue            52   male  mascu…
    ## 5 Beru Wh…    165    75 brown       light      blue            47   fema… femin…
    ## 6 Obi-Wan…    182    77 auburn, wh… fair       blue-gray       57   male  mascu…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

> ***NOTE:***  
> Note the symbols:  
> == to meet a condition (for character variables only)  
> \| for “or” conditions  
> ! for “not”

## mutate

Use the `mutate()` function to either create new columns or modify
existing columns.  
Basic usage is provided here, more advanced options are covered \[here\]
and \[here\].

### create a new column

example: duplicating an existing column

``` r
starwars %>% 
  dplyr::select(name) %>% 
  mutate(name2 = name) %>% 
  head() 
```

    ## # A tibble: 6 × 2
    ##   name           name2         
    ##   <chr>          <chr>         
    ## 1 Luke Skywalker Luke Skywalker
    ## 2 C-3PO          C-3PO         
    ## 3 R2-D2          R2-D2         
    ## 4 Darth Vader    Darth Vader   
    ## 5 Leia Organa    Leia Organa   
    ## 6 Owen Lars      Owen Lars

example: combining two columns

``` r
starwars %>% 
  dplyr::select(name, gender) %>% 
  mutate(name_gen = paste(name, "-", gender)) %>% 
  head() 
```

    ## # A tibble: 6 × 3
    ##   name           gender    name_gen                  
    ##   <chr>          <chr>     <chr>                     
    ## 1 Luke Skywalker masculine Luke Skywalker - masculine
    ## 2 C-3PO          masculine C-3PO - masculine         
    ## 3 R2-D2          masculine R2-D2 - masculine         
    ## 4 Darth Vader    masculine Darth Vader - masculine   
    ## 5 Leia Organa    feminine  Leia Organa - feminine    
    ## 6 Owen Lars      masculine Owen Lars - masculine

Here, we use the `paste()` function to combine two columns and a
hyphen.  
There are two versions of the `paste()` function: - `paste()`: combines
the pieces and adds a space betweeen them - `paste0()`: combines the
pieces without adding a space

### modify an existing column

## summarize

## group\_by

group operations

## arrange

## drop\_na

------------------------------------------------------------------------

<details>
<summary>
Session Info
</summary>

Date Run: 2022-05-27

``` r
sessionInfo()
```

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
    ## [1] forcats_0.5.1   stringr_1.4.0   dplyr_1.0.9     purrr_0.3.4    
    ## [5] readr_2.1.2     tidyr_1.2.0     tibble_3.1.5    ggplot2_3.3.6  
    ## [9] tidyverse_1.3.1
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] tidyselect_1.1.1 xfun_0.31        repr_1.1.3       haven_2.4.3     
    ##  [5] colorspace_2.0-2 vctrs_0.4.1      generics_0.1.0   htmltools_0.5.2 
    ##  [9] base64enc_0.1-3  yaml_2.2.1       utf8_1.2.2       rlang_1.0.2     
    ## [13] pillar_1.6.2     glue_1.6.2       withr_2.5.0      DBI_1.1.1       
    ## [17] dbplyr_2.1.1     modelr_0.1.8     readxl_1.4.0     lifecycle_1.0.1 
    ## [21] munsell_0.5.0    gtable_0.3.0     cellranger_1.1.0 rvest_1.0.1     
    ## [25] evaluate_0.15    knitr_1.39       tzdb_0.1.2       fastmap_1.1.0   
    ## [29] fansi_0.5.0      highr_0.9        broom_0.8.0      backports_1.2.1 
    ## [33] scales_1.1.1     jsonlite_1.7.2   fs_1.5.2         hms_1.1.0       
    ## [37] digest_0.6.27    stringi_1.7.6    grid_4.1.1       cli_3.3.0       
    ## [41] tools_4.1.1      magrittr_2.0.3   crayon_1.4.1     pkgconfig_2.0.3 
    ## [45] ellipsis_0.3.2   xml2_1.3.2       skimr_2.1.3      reprex_2.0.1    
    ## [49] lubridate_1.8.0  assertthat_0.2.1 rmarkdown_2.14   httr_1.4.2      
    ## [53] rstudioapi_0.13  R6_2.5.1         compiler_4.1.1

</details>
