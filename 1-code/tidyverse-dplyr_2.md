tidyverse II
================

``` r
library(tidyverse)
```

------------------------------------------------------------------------

## 1. arrange

Sort your dataframe in ascending/descending order

Example: Arrange in ascending order of height

``` r
starwars %>% 
  arrange(height) %>% 
  head()
```

    ## # A tibble: 6 × 14
    ##   name      height  mass hair_color skin_color eye_color birth_year sex   gender
    ##   <chr>      <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Yoda          66    17 white      green      brown            896 male  mascu…
    ## 2 Ratts Ty…     79    15 none       grey, blue unknown           NA male  mascu…
    ## 3 Wicket S…     88    20 brown      brown      brown              8 male  mascu…
    ## 4 Dud Bolt      94    45 none       blue, grey yellow            NA male  mascu…
    ## 5 R2-D2         96    32 <NA>       white, bl… red               33 none  mascu…
    ## 6 R4-P17        96    NA none       silver, r… red, blue         NA none  femin…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

Example: Arrange in descending order of height: use `-`

``` r
starwars %>% 
  arrange(-height) %>% 
  head()
```

    ## # A tibble: 6 × 14
    ##   name      height  mass hair_color skin_color eye_color birth_year sex   gender
    ##   <chr>      <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ## 1 Yarael P…    264    NA none       white      yellow            NA male  mascu…
    ## 2 Tarfful      234   136 brown      brown      blue              NA male  mascu…
    ## 3 Lama Su      229    88 none       grey       black             NA male  mascu…
    ## 4 Chewbacca    228   112 brown      unknown    blue             200 male  mascu…
    ## 5 Roos Tar…    224    82 none       grey       orange            NA male  mascu…
    ## 6 Grievous     216   159 none       brown, wh… green, y…         NA male  mascu…
    ## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
    ## #   vehicles <list>, starships <list>

------------------------------------------------------------------------

## 2. drop_na

This function will remove all rows with NAs.

``` r
starwars %>% drop_na()
```

    ## # A tibble: 29 × 14
    ##    name     height  mass hair_color skin_color eye_color birth_year sex   gender
    ##    <chr>     <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ##  1 Luke Sk…    172    77 blond      fair       blue            19   male  mascu…
    ##  2 Darth V…    202   136 none       white      yellow          41.9 male  mascu…
    ##  3 Leia Or…    150    49 brown      light      brown           19   fema… femin…
    ##  4 Owen La…    178   120 brown, gr… light      blue            52   male  mascu…
    ##  5 Beru Wh…    165    75 brown      light      blue            47   fema… femin…
    ##  6 Biggs D…    183    84 black      light      brown           24   male  mascu…
    ##  7 Obi-Wan…    182    77 auburn, w… fair       blue-gray       57   male  mascu…
    ##  8 Anakin …    188    84 blond      fair       blue            41.9 male  mascu…
    ##  9 Chewbac…    228   112 brown      unknown    blue           200   male  mascu…
    ## 10 Han Solo    180    80 brown      fair       brown           29   male  mascu…
    ## # … with 19 more rows, and 5 more variables: homeworld <chr>, species <chr>,
    ## #   films <list>, vehicles <list>, starships <list>

We dropped 59 rows, because they had at least one NA value.

**Be warned:** the `drop_na()` function will drop ALL rows that have
even a single instance of NA. Be very careful when using this, as you
may accidentally delete more rows than you intend.

More often, we want to remove NAs only from certain columns (e.g., we
want to analyze the heights, so we only care about characters whose
heights are provided). In that case, use `filter()`.

``` r
starwars %>% filter(!is.na(height))
```

    ## # A tibble: 81 × 14
    ##    name     height  mass hair_color skin_color eye_color birth_year sex   gender
    ##    <chr>     <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ##  1 Luke Sk…    172    77 blond      fair       blue            19   male  mascu…
    ##  2 C-3PO       167    75 <NA>       gold       yellow         112   none  mascu…
    ##  3 R2-D2        96    32 <NA>       white, bl… red             33   none  mascu…
    ##  4 Darth V…    202   136 none       white      yellow          41.9 male  mascu…
    ##  5 Leia Or…    150    49 brown      light      brown           19   fema… femin…
    ##  6 Owen La…    178   120 brown, gr… light      blue            52   male  mascu…
    ##  7 Beru Wh…    165    75 brown      light      blue            47   fema… femin…
    ##  8 R5-D4        97    32 <NA>       white, red red             NA   none  mascu…
    ##  9 Biggs D…    183    84 black      light      brown           24   male  mascu…
    ## 10 Obi-Wan…    182    77 auburn, w… fair       blue-gray       57   male  mascu…
    ## # … with 71 more rows, and 5 more variables: homeworld <chr>, species <chr>,
    ## #   films <list>, vehicles <list>, starships <list>

> `is.na()` is a conditional command that looks for NA values.  
> `filter(is.na(COLUMN_NAME))` will keep all NA values  
> `filter(!is.na(COLUMN_NAME))` will remove all NA values. Remember -
> `!` means “not”

------------------------------------------------------------------------

## 3. distinct

This function will remove duplicate entries/values

``` r
starwars %>% distinct()
```

    ## # A tibble: 87 × 14
    ##    name     height  mass hair_color skin_color eye_color birth_year sex   gender
    ##    <chr>     <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
    ##  1 Luke Sk…    172    77 blond      fair       blue            19   male  mascu…
    ##  2 C-3PO       167    75 <NA>       gold       yellow         112   none  mascu…
    ##  3 R2-D2        96    32 <NA>       white, bl… red             33   none  mascu…
    ##  4 Darth V…    202   136 none       white      yellow          41.9 male  mascu…
    ##  5 Leia Or…    150    49 brown      light      brown           19   fema… femin…
    ##  6 Owen La…    178   120 brown, gr… light      blue            52   male  mascu…
    ##  7 Beru Wh…    165    75 brown      light      blue            47   fema… femin…
    ##  8 R5-D4        97    32 <NA>       white, red red             NA   none  mascu…
    ##  9 Biggs D…    183    84 black      light      brown           24   male  mascu…
    ## 10 Obi-Wan…    182    77 auburn, w… fair       blue-gray       57   male  mascu…
    ## # … with 77 more rows, and 5 more variables: homeworld <chr>, species <chr>,
    ## #   films <list>, vehicles <list>, starships <list>

This will look through the entire dataset and drop duplicate entries
(rows that are an exact copy, across every single column). In our case,
it does not change our dataframe because we do not have duplicate
entries.

You can also use `distinct()` on a single column, to get the unique
values present in that column.  
Example: You want to know only what eye colors are recorded - not
who/how many, etc.; just the different colors possible in this dataset

``` r
starwars %>% distinct(eye_color)
```

    ## # A tibble: 15 × 1
    ##    eye_color    
    ##    <chr>        
    ##  1 blue         
    ##  2 yellow       
    ##  3 red          
    ##  4 brown        
    ##  5 blue-gray    
    ##  6 black        
    ##  7 orange       
    ##  8 hazel        
    ##  9 pink         
    ## 10 unknown      
    ## 11 red, blue    
    ## 12 gold         
    ## 13 green, yellow
    ## 14 white        
    ## 15 dark

------------------------------------------------------------------------

## 4. separate

## starts_with and ends_with

## if_else

## case_when

## pull

## recode

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
    ##  [1] tidyselect_1.1.2 xfun_0.31        haven_2.4.3      colorspace_2.0-2
    ##  [5] vctrs_0.4.1      generics_0.1.2   htmltools_0.5.2  yaml_2.2.1      
    ##  [9] utf8_1.2.2       rlang_1.0.2      pillar_1.7.0     glue_1.6.2      
    ## [13] withr_2.5.0      DBI_1.1.1        dbplyr_2.1.1     modelr_0.1.8    
    ## [17] readxl_1.4.0     lifecycle_1.0.1  munsell_0.5.0    gtable_0.3.0    
    ## [21] cellranger_1.1.0 rvest_1.0.1      evaluate_0.15    knitr_1.39      
    ## [25] tzdb_0.1.2       fastmap_1.1.0    fansi_0.5.0      broom_0.8.0     
    ## [29] backports_1.2.1  scales_1.1.1     jsonlite_1.7.2   fs_1.5.2        
    ## [33] hms_1.1.0        digest_0.6.27    stringi_1.7.6    grid_4.1.1      
    ## [37] cli_3.3.0        tools_4.1.1      magrittr_2.0.3   crayon_1.4.1    
    ## [41] pkgconfig_2.0.3  ellipsis_0.3.2   xml2_1.3.2       reprex_2.0.1    
    ## [45] lubridate_1.8.0  assertthat_0.2.1 rmarkdown_2.14   httr_1.4.2      
    ## [49] rstudioapi_0.13  R6_2.5.1         compiler_4.1.1

</details>
