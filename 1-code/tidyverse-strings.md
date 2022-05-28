dplyr basics
================

``` r
library(tidyverse)
```

------------------------------------------------------------------------

## string contains

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
    ##  [1] tidyselect_1.1.1 xfun_0.31        haven_2.4.3      colorspace_2.0-2
    ##  [5] vctrs_0.4.1      generics_0.1.0   htmltools_0.5.2  yaml_2.2.1      
    ##  [9] utf8_1.2.2       rlang_1.0.2      pillar_1.6.2     glue_1.6.2      
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
