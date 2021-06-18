ggplot2 – working with facets/panels
================

``` r
library(palmerpenguins)
library(ggplot2)
```

## Step 7: facets and panels

``` r
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g))+
  geom_point()+
  facet_wrap(~species)
```

![](3-ggplot_facets_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

``` r
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g))+
  geom_point()+
  facet_wrap(~species, scales = "free_x")
```

![](3-ggplot_facets_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

``` r
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g))+
  geom_point()+
  facet_grid(island~species)
```

![](3-ggplot_facets_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

``` r
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g))+
  geom_point()+
  facet_grid(.~species)
```

![](3-ggplot_facets_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g))+
  geom_point()+
  facet_grid(island~.)
```

![](3-ggplot_facets_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->
