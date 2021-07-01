using pipes
================

### A `{dplyr}` example (without pipes)

``` r
library(dplyr)
```

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

### Pipes

In this example above, we created multiple files to get to our final
desired output. An easier way to do this is using the **pipe** (%&gt;%).

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
