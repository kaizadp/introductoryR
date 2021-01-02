tidyverse
================

The `{tidyverse}` is a nice alternative to many base R functions for
data cleaning and visualization. `{tidyverse}` is a set of eight
packages that perform different functions.

1.  ggplot2
2.  tibble
3.  tidyr
4.  readr
5.  dplyr
6.  purr
7.  stringr
8.  forcats

<!-- end list -->

``` r
library(tidyverse)
```

-----

We will use the `{dplyr}` built-in dataset `starwars`

<details>

<summary>click here to explore the `starwars` dataset</summary>

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
| :----------------------------------------------- | :------- |
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
| :------------- | ---------: | -------------: | --: | --: | ----: | --------: | ---------: |
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
| :------------- | ---------: | -------------: | --------: | ----------: | ----------: |
| films          |          0 |              1 |        24 |           1 |           7 |
| vehicles       |          0 |              1 |        11 |           0 |           2 |
| starships      |          0 |              1 |        17 |           0 |           5 |

**Variable type: numeric**

| skim\_variable | n\_missing | complete\_rate |   mean |     sd | p0 |   p25 | p50 |   p75 | p100 | hist  |
| :------------- | ---------: | -------------: | -----: | -----: | -: | ----: | --: | ----: | ---: | :---- |
| height         |          6 |           0.93 | 174.36 |  34.77 | 66 | 167.0 | 180 | 191.0 |  264 | ▁▁▇▅▁ |
| mass           |         28 |           0.68 |  97.31 | 169.46 | 15 |  55.6 |  79 |  84.5 | 1358 | ▇▁▁▁▁ |
| birth\_year    |         44 |           0.49 |  87.57 | 154.69 |  8 |  35.0 |  52 |  72.0 |  896 | ▇▁▁▁▁ |

</details>

-----

-----

### A `{dplyr}` example (without pipes)

Consider this multi-part example:

From the `starwars` dataset, you want to choose only characters with
black hair.

``` r
sw_blackhair = filter(starwars, hair_color == "black")
sw_blackhair$name
```

    ##  [1] "Biggs Darklighter"   "Boba Fett"           "Lando Calrissian"   
    ##  [4] "Watto"               "Quarsh Panaka"       "Shmi Skywalker"     
    ##  [7] "Eeth Koth"           "Gregar Typho"        "Luminara Unduli"    
    ## [10] "Barriss Offee"       "Bail Prestor Organa" "Jango Fett"         
    ## [13] "Finn"

``` r
names(sw_blackhair)
```

    ##  [1] "name"       "height"     "mass"       "hair_color" "skin_color"
    ##  [6] "eye_color"  "birth_year" "sex"        "gender"     "homeworld" 
    ## [11] "species"    "films"      "vehicles"   "starships"

You then want to keep only columns related to name, height, and hair
color

``` r
sw_blackhair2 = select(sw_blackhair, name, height, hair_color)
names(sw_blackhair2)
```

    ## [1] "name"       "height"     "hair_color"

You then want to rename the `hair_color` column

``` r
sw_blackhair3 = rename(sw_blackhair2, "HairColor" = "hair_color")
names(sw_blackhair3)
```

    ## [1] "name"      "height"    "HairColor"

In this example above, we created multiple files to get to our final
desired output. An easier way to do this is using the **pipe** (%\>%).

``` r
sw2 = starwars %>% 
  filter(hair_color == "black") %>% 
  select(name, height, hair_color) %>% 
  rename("HairColor" = "hair_color")

names(sw2)
```

    ## [1] "name"      "height"    "HairColor"

``` r
str(sw2)
```

    ## tibble [13 × 3] (S3: tbl_df/tbl/data.frame)
    ##  $ name     : chr [1:13] "Biggs Darklighter" "Boba Fett" "Lando Calrissian" "Watto" ...
    ##  $ height   : int [1:13] 183 183 177 137 183 163 171 185 170 166 ...
    ##  $ HairColor: chr [1:13] "black" "black" "black" "black" ...

-----

-----

# `{dplyr}` functions - the basics

## rename

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

These functions allow you to subset a dataset.

Use `select` to subset certain columns. You can do this multiple ways:

  - choosing column names

<!-- end list -->

``` r
starwars %>% 
  select(name, height, mass) %>% 
  head()
```

  - choosing column positions

<!-- end list -->

``` r
starwars %>% 
  select(1:3) %>% 
  head()
```

  - deselecting column names/positions

<!-- end list -->

``` r
starwars %>% 
  select(-(4:14)) %>% 
  head()
```

    ## # A tibble: 6 x 3
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

    ## # A tibble: 6 x 14
    ##   name  height  mass hair_color skin_color eye_color birth_year sex   gender
    ##   <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Bigg…    183  84   black      light      brown           24   male  mascu…
    ## 2 Boba…    183  78.2 black      fair       brown           31.5 male  mascu…
    ## 3 Land…    177  79   black      dark       brown           31   male  mascu…
    ## 4 Watto    137  NA   black      blue, grey yellow          NA   male  mascu…
    ## 5 Quar…    183  NA   black      dark       brown           62   <NA>  <NA>  
    ## 6 Shmi…    163  NA   black      fair       brown           72   fema… femin…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

#### multiple conditions

For example, keep only characters with black or blond hair

``` r
starwars %>% 
  filter(hair_color %in% c("black", "blond")) %>% 
  head()
```

    ## # A tibble: 6 x 14
    ##   name  height  mass hair_color skin_color eye_color birth_year sex   gender
    ##   <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Luke…    172  77   blond      fair       blue            19   male  mascu…
    ## 2 Bigg…    183  84   black      light      brown           24   male  mascu…
    ## 3 Anak…    188  84   blond      fair       blue            41.9 male  mascu…
    ## 4 Boba…    183  78.2 black      fair       brown           31.5 male  mascu…
    ## 5 Land…    177  79   black      dark       brown           31   male  mascu…
    ## 6 Fini…    170  NA   blond      fair       blue            91   male  mascu…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

#### and/or conditions (multiple variables)

For example, keep only characters with black hair and blue eyes

``` r
starwars %>% 
  filter(hair_color == "black" & eye_color == "blue") %>% 
  head()
```

    ## # A tibble: 2 x 14
    ##   name  height  mass hair_color skin_color eye_color birth_year sex   gender
    ##   <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Lumi…    170  56.2 black      yellow     blue              58 fema… femin…
    ## 2 Barr…    166  50   black      yellow     blue              40 fema… femin…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

keep only characters with black hair *or* blue eyes

``` r
starwars %>% 
  filter(hair_color == "black" | eye_color == "blue") %>% 
  head()
```

    ## # A tibble: 6 x 14
    ##   name  height  mass hair_color skin_color eye_color birth_year sex   gender
    ##   <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Luke…    172    77 blond      fair       blue            19   male  mascu…
    ## 2 Owen…    178   120 brown, gr… light      blue            52   male  mascu…
    ## 3 Beru…    165    75 brown      light      blue            47   fema… femin…
    ## 4 Bigg…    183    84 black      light      brown           24   male  mascu…
    ## 5 Anak…    188    84 blond      fair       blue            41.9 male  mascu…
    ## 6 Wilh…    180    NA auburn, g… fair       blue            64   male  mascu…
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

    ## # A tibble: 6 x 14
    ##   name  height  mass hair_color skin_color eye_color birth_year sex   gender
    ##   <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Luke…    172    77 blond      fair       blue            19   male  mascu…
    ## 2 Dart…    202   136 none       white      yellow          41.9 male  mascu…
    ## 3 Leia…    150    49 brown      light      brown           19   fema… femin…
    ## 4 Owen…    178   120 brown, gr… light      blue            52   male  mascu…
    ## 5 Beru…    165    75 brown      light      blue            47   fema… femin…
    ## 6 Obi-…    182    77 auburn, w… fair       blue-gray       57   male  mascu…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

## mutate

### create a new column

### modify an existing column

## summarize

## group\_by

group operations

## recode

## arrange

## drop\_na

# `{dplyr}` functions - next level

## distinct

## starts\_with and ends\_with

## string contains

## join

## bind\_rows and bind\_columns

## if\_else

## case\_when

## pull

-----

<details>

<summary>Session Info</summary>

Date Run: 2021-01-02

``` r
sessionInfo()
```

    ## R version 4.0.2 (2020-06-22)
    ## Platform: x86_64-apple-darwin17.0 (64-bit)
    ## Running under: macOS Catalina 10.15.7
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRblas.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] forcats_0.5.0   stringr_1.4.0   dplyr_1.0.1     purrr_0.3.4    
    ## [5] readr_1.3.1     tidyr_1.1.1     tibble_3.0.3    ggplot2_3.3.2  
    ## [9] tidyverse_1.3.0
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] tidyselect_1.1.0 xfun_0.16        repr_1.1.0       haven_2.3.1     
    ##  [5] colorspace_1.4-1 vctrs_0.3.2      generics_0.0.2   htmltools_0.5.0 
    ##  [9] base64enc_0.1-3  yaml_2.2.1       utf8_1.1.4       blob_1.2.1      
    ## [13] rlang_0.4.7      pillar_1.4.6     glue_1.4.1       withr_2.2.0     
    ## [17] DBI_1.1.0        dbplyr_1.4.4     modelr_0.1.8     readxl_1.3.1    
    ## [21] lifecycle_0.2.0  munsell_0.5.0    gtable_0.3.0     cellranger_1.1.0
    ## [25] rvest_0.3.6      evaluate_0.14    knitr_1.29       fansi_0.4.1     
    ## [29] highr_0.8        broom_0.7.0      Rcpp_1.0.5       scales_1.1.1    
    ## [33] backports_1.1.8  jsonlite_1.7.0   fs_1.5.0         hms_0.5.3       
    ## [37] digest_0.6.25    stringi_1.4.6    grid_4.0.2       cli_2.0.2       
    ## [41] tools_4.0.2      magrittr_1.5     crayon_1.3.4     pkgconfig_2.0.3 
    ## [45] ellipsis_0.3.1   xml2_1.3.2       skimr_2.1.2      reprex_0.3.0    
    ## [49] lubridate_1.7.9  assertthat_0.2.1 rmarkdown_2.3    httr_1.4.2      
    ## [53] rstudioapi_0.11  R6_2.4.1         compiler_4.0.2

</details>
