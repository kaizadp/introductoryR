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

| skim_variable | n_missing | complete_rate | min | max | empty | n_unique | whitespace |
|:--------------|----------:|--------------:|----:|----:|------:|---------:|-----------:|
| name          |         0 |          1.00 |   3 |  21 |     0 |       87 |          0 |
| hair_color    |         5 |          0.94 |   4 |  13 |     0 |       12 |          0 |
| skin_color    |         0 |          1.00 |   3 |  19 |     0 |       31 |          0 |
| eye_color     |         0 |          1.00 |   3 |  13 |     0 |       15 |          0 |
| sex           |         4 |          0.95 |   4 |  14 |     0 |        4 |          0 |
| gender        |         4 |          0.95 |   8 |   9 |     0 |        2 |          0 |
| homeworld     |        10 |          0.89 |   4 |  14 |     0 |       48 |          0 |
| species       |         4 |          0.95 |   3 |  14 |     0 |       37 |          0 |

**Variable type: list**

| skim_variable | n_missing | complete_rate | n_unique | min_length | max_length |
|:--------------|----------:|--------------:|---------:|-----------:|-----------:|
| films         |         0 |             1 |       24 |          1 |          7 |
| vehicles      |         0 |             1 |       11 |          0 |          2 |
| starships     |         0 |             1 |       17 |          0 |          5 |

**Variable type: numeric**

| skim_variable | n_missing | complete_rate |   mean |     sd |  p0 |   p25 | p50 |   p75 | p100 | hist  |
|:--------------|----------:|--------------:|-------:|-------:|----:|------:|----:|------:|-----:|:------|
| height        |         6 |          0.93 | 174.36 |  34.77 |  66 | 167.0 | 180 | 191.0 |  264 | ▁▁▇▅▁ |
| mass          |        28 |          0.68 |  97.31 | 169.46 |  15 |  55.6 |  79 |  84.5 | 1358 | ▇▁▁▁▁ |
| birth_year    |        44 |          0.49 |  87.57 | 154.69 |   8 |  35.0 |  52 |  72.0 |  896 | ▇▁▁▁▁ |

</details>

------------------------------------------------------------------------

# `{dplyr}` functions - the basics

------------------------------------------------------------------------

## 1. rename

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

------------------------------------------------------------------------

## 2. select

Use this to subset certain columns.

general format: `select()`

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

------------------------------------------------------------------------

## 3. filter

Use `filter` to subset rows where certain conditions are met.

#### 3.1. single condition

For example, filter only characters with black hair

``` r
starwars %>% 
  filter(hair_color == "black") %>% 
  head()
```

    ## # A tibble: 6 × 14
    ##   name      height  mass hair_color skin_color eye_color birth_year sex   gender
    ##   <chr>      <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Biggs Da…    183  84   black      light      brown           24   male  mascu…
    ## 2 Boba Fett    183  78.2 black      fair       brown           31.5 male  mascu…
    ## 3 Lando Ca…    177  79   black      dark       brown           31   male  mascu…
    ## 4 Watto        137  NA   black      blue, grey yellow          NA   male  mascu…
    ## 5 Quarsh P…    183  NA   black      dark       brown           62   <NA>  <NA>  
    ## 6 Shmi Sky…    163  NA   black      fair       brown           72   fema… femin…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

#### 3.2. multiple conditions

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

#### 3.3. and/or conditions (multiple variables)

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
    ##   name      height  mass hair_color skin_color eye_color birth_year sex   gender
    ##   <chr>      <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Luke Sky…    172    77 blond      fair       blue            19   male  mascu…
    ## 2 Owen Lars    178   120 brown, gr… light      blue            52   male  mascu…
    ## 3 Beru Whi…    165    75 brown      light      blue            47   fema… femin…
    ## 4 Biggs Da…    183    84 black      light      brown           24   male  mascu…
    ## 5 Anakin S…    188    84 blond      fair       blue            41.9 male  mascu…
    ## 6 Wilhuff …    180    NA auburn, g… fair       blue            64   male  mascu…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

#### 3.4. “not” conditions

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
    ##   name      height  mass hair_color skin_color eye_color birth_year sex   gender
    ##   <chr>      <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Luke Sky…    172    77 blond      fair       blue            19   male  mascu…
    ## 2 Darth Va…    202   136 none       white      yellow          41.9 male  mascu…
    ## 3 Leia Org…    150    49 brown      light      brown           19   fema… femin…
    ## 4 Owen Lars    178   120 brown, gr… light      blue            52   male  mascu…
    ## 5 Beru Whi…    165    75 brown      light      blue            47   fema… femin…
    ## 6 Obi-Wan …    182    77 auburn, w… fair       blue-gray       57   male  mascu…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

> ***NOTE:***  
> Note the symbols:  
> == to meet a condition (for character variables only)  
> \| for “or” conditions  
> ! for “not”

#### 3.5. `%in%` vs. `==`

By default, when using `==` or `!=`, the `filter()` command will also
drop all NA values - even if we want to retain those rows.  
Therefore, a better alternative is to use `%in%`, as described above.

Examples:

Keep black hair color

``` r
starwars %>% 
  filter(hair_color %in% c("black")) %>% 
  head()
```

Remove black hair color

``` r
starwars %>% 
  filter(!hair_color %in% c("black")) %>% 
  head()
```

------------------------------------------------------------------------

## 4. mutate

Use the `mutate()` function to either create new columns or modify
existing columns.  
Basic usage is provided here, more advanced options are covered \[here\]
and \[here\].

### 4.1. create a new column

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

> Here, we use the `paste()` function to combine two columns and a
> hyphen.  
> There are two versions of the `paste()` function:  
> - `paste()`: combines the pieces and adds a space between them  
> - `paste0()`: combines the pieces without adding a space

### 4.2. modify an existing column

Sometimes, you want to modify an existing column without creating a new
column

Example: `height` is currently listed in cm, and we want to change this
to m.

``` r
starwars %>% 
#  dplyr::select(height) %>% 
  mutate(height = height/100) %>% 
  head() 
```

    ## # A tibble: 6 × 14
    ##   name      height  mass hair_color skin_color eye_color birth_year sex   gender
    ##   <chr>      <dbl> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Luke Sky…   1.72    77 blond      fair       blue            19   male  mascu…
    ## 2 C-3PO       1.67    75 <NA>       gold       yellow         112   none  mascu…
    ## 3 R2-D2       0.96    32 <NA>       white, bl… red             33   none  mascu…
    ## 4 Darth Va…   2.02   136 none       white      yellow          41.9 male  mascu…
    ## 5 Leia Org…   1.5     49 brown      light      brown           19   fema… femin…
    ## 6 Owen Lars   1.78   120 brown, gr… light      blue            52   male  mascu…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

> **NOTE \#1: Be very wary** when modifying an existing column, as it is
> very easy to make a mistake and not catch it.  
> Try this example, what does it do? What happens if you run this same
> line of code two times?

``` r
starwars = starwars %>% dplyr::select(height) %>% mutate(height = height/100)
```

> **NOTE \#2: UNITS.** Always include units in the column name, so there
> is no confusion about the data. The columns in the `starwars` do not
> include units (sigh), so we need to look up the [package/dataset info
> online](https://dplyr.tidyverse.org/reference/starwars.html) to fully
> understand the data. NOT IDEAL. Always, always, always include units.

Some other examples where you can use `mutate` to modify an existing
column:

-   changing the column type: `mutate(x = as.numeric(x))`,
    `mutate(y = as.character(y))`
-   changing the order levels for a factor column:
    `mutate(x = factor(x, levels = c(X, Y, Z)))`
-   rounding a numeric column to a certain number of decimal places:
    `mutate(x = round(x, 2))`

------------------------------------------------------------------------

## 5. summarize

The `summarize` function allows you to calculate summary statistics
(mean, median, standard deviation, etc.) for your data

``` r
starwars %>% 
  summarise(height_mean = mean(height),
            height_median = median(height),
            height_sd = sd(height))
```

This line of code above gives us NA in the output - because there are
some NA values in the `height` column.  
To avoid this issue, include `na.rm = TRUE` in the arguments, to remove
the NAs.

``` r
starwars %>% 
  summarise(height_mean = mean(height, na.rm = TRUE),
            height_median = median(height, na.rm = TRUE),
            height_sd = sd(height, na.rm = TRUE))
```

    ## # A tibble: 1 × 3
    ##   height_mean height_median height_sd
    ##         <dbl>         <int>     <dbl>
    ## 1        174.           180      34.8

## 6. group_by

group operations

You can use `group_by()` with `mutate` and `summarize` to perform the
calculations by group, i.e. to get summary statistics, etc. for each set
of values, given a grouping column.

Example: We previously calculated mean height for the entire dataset.
But what if we want mean height for each species?

``` r
starwars %>% 
  group_by(species) %>% 
  dplyr::summarise(height_mean = mean(height, na.rm = TRUE),
                  n = n())
```

    ## # A tibble: 38 × 3
    ##    species   height_mean     n
    ##    <chr>           <dbl> <int>
    ##  1 Aleena            79      1
    ##  2 Besalisk         198      1
    ##  3 Cerean           198      1
    ##  4 Chagrian         196      1
    ##  5 Clawdite         168      1
    ##  6 Droid            131.     6
    ##  7 Dug              112      1
    ##  8 Ewok              88      1
    ##  9 Geonosian        183      1
    ## 10 Gungan           209.     3
    ## # … with 28 more rows

The `n()` function used here gives us the count, or the number of rows
present in that group. So, there was only 1 from the Aleena species, but
6 Droids.

> **NOTE:** because of package masking, sometimes summarize does not
> work well with group_by(), giving us a single value instead of
> grouped. The workaround for this is using the namespace
> (`dplyr::summarize()`)

------------------------------------------------------------------------

<details>
<summary>
Session Info
</summary>

Date Run: 2022-07-20

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
    ## [5] readr_2.1.2     tidyr_1.2.0     tibble_3.1.7    ggplot2_3.3.6  
    ## [9] tidyverse_1.3.1
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] tidyselect_1.1.2 xfun_0.31        repr_1.1.3       haven_2.4.3     
    ##  [5] colorspace_2.0-2 vctrs_0.4.1      generics_0.1.2   htmltools_0.5.2 
    ##  [9] base64enc_0.1-3  yaml_2.2.1       utf8_1.2.2       rlang_1.0.2     
    ## [13] pillar_1.7.0     glue_1.6.2       withr_2.5.0      DBI_1.1.1       
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
